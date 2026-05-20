resource "yandex_compute_disk" "storage_disk" {
  count = var.storage_disk_count
  name  = "storage-disk-${count.index + 1}"
  type  = var.disk_type
  size  = var.extra_disk_size
  zone  = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"
  platform_id = var.platform_id
  zone        = var.default_zone

  resources {
    cores         = var.storage_cores
    memory        = var.storage_memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.disk_type
      size     = var.storage_boot_disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.enable_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    content {
      disk_id = secondary_disk.value.id
    }
  }
}