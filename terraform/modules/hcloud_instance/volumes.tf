resource "hcloud_volume" "volumes" {
  name      = "${element(hcloud_server.services.*.name, count.index)}-data"
  size      = var.volume_size
  format    = "xfs"
  automount = false
  server_id = element(hcloud_server.services.*.id, count.index)
  count     = var.volume == true ? var.instance_count : 0
}
