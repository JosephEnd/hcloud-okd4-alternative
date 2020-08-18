/* resource "cloudflare_record" "dns_a_services" {
  zone_id = var.dns_zone_id
  name    = "services.${var.dns_domain}"
  value   = module.services.ipv4_addresses[0]
  type    = "A"
  ttl     = 1
  count   = var.bootstrap == true ? 1 : 0
}
*/
