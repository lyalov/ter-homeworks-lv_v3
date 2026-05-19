locals {
  # Web-серверы (из count-vm.tf)
  webservers = [
    for i in range(2) : {
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

  # Storage
  storage = [{
    name        = yandex_compute_instance.storage.name
    external_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
    fqdn        = yandex_compute_instance.storage.fqdn
  }]

  # Генерируем контент через templatefile
  inventory_content = templatefile("${path.module}/hosts.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
}

output "inventory_content" {
  value     = local.inventory_content
  sensitive = false
}