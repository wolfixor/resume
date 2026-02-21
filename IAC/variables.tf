variable "namespace" {
  type = string
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "complex_image" {
  type = string
}

variable "complex_replicas" {
  type    = number
  default = 1
}

variable "complex_host" {
  type = string
}

variable "dashboard_image" {
  type = string
}

variable "dashboard_replicas" {
  type    = number
  default = 1
}

variable "dashboard_host" {
  type = string
}

variable "landing_image" {
  type = string
}

variable "landing_replicas" {
  type    = number
  default = 1
}

variable "landing_host" {
  type = string
}


variable "userwebsite_image" {
  type = string
}

variable "userwebsite_replicas" {
  type    = number
  default = 1
}

variable "userwebsite_host" {
  type = string
}

# Application secrets
variable "mongodb_uri" {
  description = "MongoDB connection string"
  type        = string
  sensitive   = true
  default     = ""
}

variable "jwt_secret" {
  description = "JWT secret key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "complex_public_url" {
  description = "Complex app public URL"
  type        = string
  default     = ""
}

# Payment and merchant variables
variable "zarinpal_merchant_id" {
  description = "ZarinPal merchant ID"
  type        = string
  sensitive   = true
  default     = ""
}

# Arvan Cloud variables
variable "arvan_api_token" {
  description = "Arvan API token"
  type        = string
  sensitive   = true
  default     = ""
}

variable "arvan_access_key" {
  description = "Arvan access key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "arvan_bucket_name" {
  description = "Arvan bucket name"
  type        = string
  default     = ""
}

# SMS variables
variable "sms_ir_line_number" {
  description = "SMS.ir line number"
  type        = string
  sensitive   = true
  default     = ""
}

variable "sms_ir_template_id" {
  description = "SMS.ir template ID"
  type        = string
  sensitive   = true
  default     = ""
}

variable "sms_ir_api_key" {
  description = "SMS.ir API key"
  type        = string
  sensitive   = true
  default     = ""
}

# AI variables
variable "ai_deepseek_key" {
  description = "AI DeepSeek API key"
  type        = string
  sensitive   = true
  default     = ""
}

# Public URLs
variable "next_public_base_userwebsite_payment_url" {
  description = "Next.js public base user website payment URL"
  type        = string
  default     = ""
}

variable "use_external_secrets" {
  description = "Whether to use External Secrets Operator"
  type        = bool
  default     = false
}

variable "vault_token" {
  description = "Vault authentication token"
  type        = string
  sensitive   = true
  default     = ""
}

