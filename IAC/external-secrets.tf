# External Secrets Operator (if you want to use AWS Secrets Manager/Vault)
resource "kubernetes_manifest" "external_secret" {
  count = var.use_external_secrets ? 1 : 0
  
  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ExternalSecret"
    metadata = {
      name      = "app-secrets"
      namespace = var.namespace
    }
    spec = {
      refreshInterval = "1h"
      secretStoreRef = {
        name = "aws-secrets-store"
        kind = "SecretStore"
      }
      target = {
        name = "app-secrets"
        creationPolicy = "Owner"
      }
      data = [
        {
          secretKey = "MONGODB_URI"
          remoteRef = {
            key = "prod/mongodb"
            property = "uri"
          }
        }
      ]
    }
  }
}