resource "hcloud_server" "server" {
  count       = var.instance_count
  name        = "${format("${var.name}")}.${var.dns_domain}"
  image       = var.image
  server_type = var.server_type
  keep_disk   = var.keep_disk
  ssh_keys    = var.ssh_keys
  user_data   = var.user_data
  location    = var.location
  backups     = var.backups
  lifecycle {
    ignore_changes = [user_data, image]
  }
}

resource "hcloud_floating_ip_assignment" "services-main" {
  count = var.instance_count
  floating_ip_id = hcloud_floating_ip.services-ip.id
  server_id = element(hcloud_server.server.*.id, count.index)
}

resource "hcloud_floating_ip" "services-ip" {
  type = "ipv4"
  home_location = "nbg1"
}



resource "hcloud_rdns" "dns-ptr-ipv4" {
  count      = var.instance_count
  server_id  = element(hcloud_server.server.*.id, count.index)
  ip_address = element(hcloud_server.server.*.ipv4_address, count.index)
  dns_ptr    = element(hcloud_server.server.*.name, count.index)
}

resource "hcloud_rdns" "dns-ptr-ipv6" {
  count      = var.instance_count
  server_id  = element(hcloud_server.server.*.id, count.index)
  ip_address = "${element(hcloud_server.server.*.ipv6_address, count.index)}1"
  dns_ptr    = element(hcloud_server.server.*.name, count.index)
}
