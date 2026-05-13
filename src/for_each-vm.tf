# Data-источник только для образа (он не создаётся в проекте)
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}


locals {
  ssh_public_key = file("${pathexpand("~/.ssh/id_ed25519.pub")}")
  db_vms_map     = { for vm in var.each_vm : vm.vm_name => vm }
}

variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 4
      ram         = 8
      disk_volume = 50
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 4
      disk_volume = 50
    }
  ]
}

resource "yandex_compute_instance" "db" {
  for_each = local.db_vms_map

  name        = "db-${each.key}"
  hostname    = "db-${each.key}"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}