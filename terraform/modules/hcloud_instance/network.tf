#resource "hcloud_server_network" "server_network" {
#  server_id = element(hcloud_server.services.*.id, count.index)
#  subnet_id = var.subnet
#  count = length(hcloud_server.services.*.id)
#}
