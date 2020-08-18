output "server_ids" {
  value = "${hcloud_server.services.*.id}"
}

output "server_names" {
  value = "${hcloud_server.services.*.name}"
}

#output "internal_ipv4_addresses" {
#  value = "${hcloud_server_network.server_network.*.ip}"
#}

output "ipv4_addresses" {
  value = "${hcloud_server.services.*.ipv4_address}"
}

output "ipv6_addresses" {
  value = "${hcloud_server.services.*.ipv6_address}"
}
