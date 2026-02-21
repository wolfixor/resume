output "cdn_domain_id" {
  value = arvan_cdn_domain.main.id
}

output "dns_zone_id" {
  value = var.create_dns_zone ? arvan_dns_zone.main[0].id : null
}

output "dns_records" {
  value = arvan_dns_record.app_records
}