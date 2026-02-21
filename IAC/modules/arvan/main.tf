# Arvan Cloud CDN Configuration
resource "arvan_cdn_domain" "main" {
  domain = var.domain
  
  # Basic CDN settings
  cache_level = "standard"
  
  # SSL settings
  ssl_status = "active"
  
  # Origin settings
  origin {
    address = var.origin_address
    port    = var.origin_port
  }
}

# Arvan Cloud DNS Zone (optional)
resource "arvan_dns_zone" "main" {
  count  = var.create_dns_zone ? 1 : 0
  domain = var.domain
}

# DNS Records for your applications
resource "arvan_dns_record" "app_records" {
  for_each = var.dns_records
  
  zone   = var.domain
  name   = each.key
  type   = each.value.type
  value  = each.value.value
  ttl    = each.value.ttl
  
  depends_on = [arvan_dns_zone.main]
}