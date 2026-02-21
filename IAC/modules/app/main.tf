# Kubernetes provider configuration is inherited from root module

# Deployment
resource "kubernetes_deployment" "app" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = { app = var.name }
  }

  lifecycle {
    ignore_changes = [
      spec[0].template[0].metadata[0].annotations
    ]
  }

  spec {
    replicas = var.replicas
    revision_history_limit = 1
    progress_deadline_seconds = 600

    selector {
      match_labels = { app = var.name }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "0"
      }
    }

    template {
      metadata {
        labels = { app = var.name, name = var.name }
      }

      spec {
        affinity {
          node_affinity {
            required_during_scheduling_ignored_during_execution {
              node_selector_term {
                match_expressions {
                  key      = var.node_selector_key
                  operator = "In"
                  values   = [var.node_selector_value]
                }
              }
            }
          }
        }

        toleration {
          key      = "role"
          operator = "Equal"
          value    = "cloud-container-g2"
          effect   = "NoSchedule"
        }

        container {
          name  = var.name
          image = var.image
          image_pull_policy = "Always"

          port {
            container_port = var.container_port
          }

          resources {
            requests = var.resources.requests
            limits   = var.resources.limits
          }

          # Environment variables from secrets
          dynamic "env" {
            for_each = var.env_secrets
            content {
              name = env.key
              value_from {
                secret_key_ref {
                  name = var.secrets_name
                  key  = env.value
                }
              }
            }
          }

          # Direct environment variables
          dynamic "env" {
            for_each = var.env_vars
            content {
              name  = env.key
              value = env.value
            }
          }
        }

        dns_policy                     = "ClusterFirst"
        restart_policy                 = "Always"
        scheduler_name                 = "default-scheduler"
        termination_grace_period_seconds = 30
      }
    }
  }
}

# Service
resource "kubernetes_service" "app" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = { app = var.name }
  }

  spec {
    selector = { app = var.name }

    port {
      name        = "http"
      port        = var.service_port
      target_port = var.container_port
      protocol    = "TCP"
    }

    type = "ClusterIP"
  }
}

# Ingress (optional: only create if host provided)
resource "kubernetes_ingress_v1" "app" {
  count = length(trimspace(var.host)) > 0 ? 1 : 0

  metadata {
    name      = "${var.name}-ingress"
    namespace = var.namespace
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      host = var.host
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.app.metadata[0].name
              port { number = var.service_port }
            }
          }
        }
      }
    }
  }
}

# HPA v2
resource "kubernetes_horizontal_pod_autoscaler_v2" "app" {
  count = var.hpa.enabled ? 1 : 0

  metadata {
    name      = var.name
    namespace = var.namespace
    labels = { app = var.name }
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.app.metadata[0].name
    }

    min_replicas = var.hpa.min_replicas
    max_replicas = var.hpa.max_replicas

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = var.hpa.cpu_utilization
        }
      }
    }

    metric {
      type = "Resource"
      resource {
        name = "memory"
        target {
          type                = "Utilization"
          average_utilization = var.hpa.memory_utilization
        }
      }
    }
  }
}