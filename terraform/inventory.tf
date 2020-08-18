data "template_file" "ansible_inventory" {
  template = file("./templates/inventory.tpl")
  vars = {
    services_node  = join("\n", module.services.server_names)
    bootstrap_node = join("\n", module.bootstrap.server_names)
    control_nodes   = join("\n", module.control.server_names)
    worker_nodes   = join("\n", module.worker.server_names)
  }
}

resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "../inventory.ini"
}
