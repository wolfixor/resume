terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
    arvan = {
      source  = "arvancloud/arvan"
      version = "~> 0.6.2"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}


resource "kubernetes_namespace" "main" {
  metadata {
    name = var.namespace
  }
}


# Apps
module "complex" {
  source    = "./modules/app"
  namespace = var.namespace
  name      = "complex"
  image     = var.complex_image
  replicas  = var.complex_replicas
  host      = var.complex_host
  
  env_secrets = {
    MONGODB_URI             = "MONGODB_URI"
    JWT_SECRET              = "JWT_SECRET"
    ZARINPAL_MERCHANT_ID    = "ZARINPAL_MERCHANT_ID"
    ARVAN_API_TOKEN         = "ARVAN_API_TOKEN"
    ARVAN_ACCESS_KEY        = "ARVAN_ACCESS_KEY"
    ARVAN_BUCKET_NAME       = "ARVAN_BUCKET_NAME"
    SMS_IR_LINE_NUMBER      = "SMS_IR_LINE_NUMBER"
    SMS_IR_TEMPLATE_ID      = "SMS_IR_TEMPLATE_ID"
    SMS_IR_API_KEY          = "SMS_IR_API_KEY"
    AI_DEEPSEEK_KEY         = "AI_DEEPSEEK_KEY"
    NEXT_PUBLIC_BASE_USERWEBSITE_PAYMENT_URL = "NEXT_PUBLIC_BASE_USERWEBSITE_PAYMENT_URL"
    NEXT_PUBLIC_COMPLEX_URL = "NEXT_PUBLIC_COMPLEX_URL"
  }
  
  env_vars = {
    NODE_ENV = "production"
    PORT     = "3000"
  }
}

module "dashboard" {
  source    = "./modules/app"
  namespace = var.namespace
  name      = "dashboard"
  image     = var.dashboard_image
  replicas  = var.dashboard_replicas
  host      = var.dashboard_host
  
  env_secrets = {
    MONGODB_URI             = "MONGODB_URI"
    JWT_SECRET              = "JWT_SECRET"
    ZARINPAL_MERCHANT_ID    = "ZARINPAL_MERCHANT_ID"
    ARVAN_API_TOKEN         = "ARVAN_API_TOKEN"
    ARVAN_ACCESS_KEY        = "ARVAN_ACCESS_KEY"
    ARVAN_BUCKET_NAME       = "ARVAN_BUCKET_NAME"
    SMS_IR_LINE_NUMBER      = "SMS_IR_LINE_NUMBER"
    SMS_IR_TEMPLATE_ID      = "SMS_IR_TEMPLATE_ID"
    SMS_IR_API_KEY          = "SMS_IR_API_KEY"
    AI_DEEPSEEK_KEY         = "AI_DEEPSEEK_KEY"
    NEXT_PUBLIC_BASE_USERWEBSITE_PAYMENT_URL = "NEXT_PUBLIC_BASE_USERWEBSITE_PAYMENT_URL"
  }
  
  env_vars = {
    NODE_ENV = "production"
    PORT     = "3000"
  }
}

module "landing" {
  source    = "./modules/app"
  namespace = var.namespace
  name      = "landing"
  image     = var.landing_image
  replicas  = var.landing_replicas
  host      = var.landing_host
}

module "userwebsite" {
  source    = "./modules/app"
  namespace = var.namespace
  name      = "userwebsite"
  image     = var.userwebsite_image
  replicas  = var.userwebsite_replicas
  host      = var.userwebsite_host
}
