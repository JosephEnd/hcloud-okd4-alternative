resource "hcloud_network" "network" {
  name     = var.dns_domain
  ip_range = var.network_cidr
}

resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.network.id
  type         = "server"
  network_zone = "eu-central"
  ip_range     = var.subnet_cidr
}


resource "hcloud_floating_ip_assignment" "services-main" {
  floating_ip_id = "${hcloud_floating_ip.services-ip.id}"
  server_id = "${hcloud_server.services.id}"
}

resource "hcloud_server" "services" {
  name = "services"
  image = "ubuntu-20.04"
  server_type = "cx11"
  datacenter = "nbg1-dc3"
}

resource "hcloud_floating_ip" "services-ip" {
  type = "ipv4"
  home_location = "nbg1"
}

resource "cloudflare_record" "dns-a" {
  zone_id = var.dns_zone_id
  name    = element(hcloud_server.services.*.name)
  value   = element(hcloud_floating_ip.services-ip.*.ip_address)
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "dns-aaaa" {
  count   = var.instance_count
  zone_id = var.dns_zone_id
  name    = element(hcloud_server.server.*.name, count.index)
  value   = "${element(hcloud_server.server.*.ipv6_address, count.index)}1"
  type    = "AAAA"
  ttl     = 1
}
