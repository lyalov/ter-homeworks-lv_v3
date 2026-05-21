locals {
  webs = [
    for i in range(var.web_count) : {
      name = "web-${i + 1}"
      ip   = yandex_compute_instance.web[i].network_interface[0].nat_ip_address
      fqdn = yandex_compute_instance.web[i].fqdn
    }
  ]

  dbs = [
    for k, v in yandex_compute_instance.db : {
      name = k
      ip   = v.network_interface[0].nat_ip_address
      fqdn = v.fqdn
    }
  ]

  store = [{
    name = yandex_compute_instance.storage.name
    ip   = yandex_compute_instance.storage.network_interface[0].nat_ip_address
    fqdn = yandex_compute_instance.storage.fqdn
  }]
}

output "inventory_content" {
  value = templatefile("${path.module}/hosts.tftpl", {
    webs  = local.webs
    dbs   = local.dbs
    store = local.store
  })
  sensitive = false
}