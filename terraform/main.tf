module "services" {
  source         = "./modules/hcloud_instance"
  instance_count = var.bootstrap == true ? 1 : 0
  location       = var.location
  name           = "services"
  dns_domain     = var.dns_domain
  dns_internal_ip  = true
  image          = "ubuntu-20.04"
  user_data      = file("templates/cloud-init.tpl")
  ssh_keys       = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name
  server_type    = "cx11"
  subnet         = hcloud_network_subnet.subnet.id
}


module "bootstrap" {
  source           = "./modules/hcloud_coreos"
  instance_count   = var.bootstrap == true ? 1 : 0
  location         = var.location
  name             = "bootstrap"
  dns_domain       = var.dns_domain
  dns_internal_ip  = true
  image            = data.hcloud_image.image.id
  image_name       = var.image
  server_type      = "cx21"
  subnet           = hcloud_network_subnet.subnet.id
  ignition_url     = var.bootstrap == true ? "http://bootstrap.${var.dns_domain}:8080/bootstrap.ign" : ""
  ignition_version = var.image == "fcos" ? "3.0.0" : "2.2.0"
}

module "control" {
  source           = "./modules/hcloud_coreos"
  instance_count   = var.replicas_master
  location         = var.location
  name             = "control"
  dns_domain       = var.dns_domain
  dns_internal_ip  = true
  image            = data.hcloud_image.image.id
  image_name       = var.image
  server_type      = "cx21"
  subnet           = hcloud_network_subnet.subnet.id
  ignition_url     = "https://api-int.${var.dns_domain}:22623/config/master"
  ignition_cacert  = local.ignition_master_cacert
  ignition_version = var.image == "fcos" ? "3.0.0" : "2.2.0"
}

module "worker" {
  source           = "./modules/hcloud_coreos"
  instance_count   = var.replicas_worker
  location         = var.location
  name             = "worker"
  dns_domain       = var.dns_domain
  dns_internal_ip  = true
  image            = data.hcloud_image.image.id
  image_name       = var.image
  server_type      = "cx21"
  subnet           = hcloud_network_subnet.subnet.id
  ignition_url     = "https://api-int.${var.dns_domain}:22623/config/worker"
  ignition_cacert  = local.ignition_worker_cacert
  ignition_version = var.image == "fcos" ? "3.0.0" : "2.2.0"
}


