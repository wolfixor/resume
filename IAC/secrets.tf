# Kubernetes secrets for applications (fallback when not using Vault)
resource "kubernetes_secret" "app_secrets" {
  count = var.use_external_secrets ? 0 : 1
  
  metadata {
    name      = "app-secrets"
    namespace = var.namespace
  }

  data = {
    # Core environment
    NODE_ENV = var.namespace
    NAMESPACE = var.namespace
    
    # Database
    MONGODB_URI = var.mongodb_uri
    
    # Authentication
    JWT_SECRET = var.jwt_secret
    
    # Payment
    ZARINPAL_MERCHANT_ID = var.zarinpal_merchant_id
    
    # Arvan Cloud
    ARVAN_API_TOKEN = var.arvan_api_token
    ARVAN_ACCESS_KEY = var.arvan_access_key
    ARVAN_BUCKET_NAME = var.arvan_bucket_name
    
    # SMS Service
    SMS_IR_LINE_NUMBER = var.sms_ir_line_number
    SMS_IR_TEMPLATE_ID = var.sms_ir_template_id
    SMS_IR_API_KEY = var.sms_ir_api_key
    
    # AI Service
    AI_DEEPSEEK_KEY = var.ai_deepseek_key
    
    # Public URLs
    NEXT_PUBLIC_BASE_USERWEBSITE_PAYMENT_URL = var.next_public_base_userwebsite_payment_url
    NEXT_PUBLIC_COMPLEX_URL = var.complex_public_url

  }

  type = "Opaque"
}