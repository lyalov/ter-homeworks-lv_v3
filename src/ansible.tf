locals {
  webservers = [
    for i in range(var.web_count) : {
      name        = "web-${i + 1}"
      external_ip = yandex_compute_instance.web[i].network_interface[0].nat_ip_address
      fqdn        = yandex_compute_instance.web[i].fqdn
    }
  ]

  databases = [
    for key, vm in yandex_compute_instance.db : {
      name        = key
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]

  storage = [{
    name        = yandex_compute_instance.storage.name
    external_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
    fqdn        = yandex_compute_instance.storage.fqdn
  }]
}

output "inventory_content" {
  value = templatefile("${path.module}/hosts.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
  sensitive = false
}