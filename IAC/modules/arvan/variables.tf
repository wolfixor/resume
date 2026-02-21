variable "domain" {
  type        = string
  description = "Domain name for Arvan Cloud services"
}

variable "origin_address" {
  type        = string
  description = "Origin server address for CDN"
}

variable "origin_port" {
  type        = number
  description = "Origin server port"
  default     = 80
}

variable "create_dns_zone" {
  type        = bool
  description = "Whether to create DNS zone in Arvan Cloud"
  default     = false
}

variable "dns_records" {
  type = map(object({
    type  = string
    value = string
    ttl   = number
  }))
  description = "DNS records to create"
  default     = {}
}