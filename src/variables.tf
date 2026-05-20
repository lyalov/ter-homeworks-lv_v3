### Основные переменные YC
variable "token" { type = string; sensitive = true }
variable "cloud_id" { type = string }
variable "folder_id" { type = string }

### Сетевые переменные
variable "default_zone" { type = string; default = "ru-central1-a" }
variable "vpc_name" { type = string; default = "develop" }
variable "default_cidr" { type = list(string); default = ["10.0.1.0/24"] }

### Глобальные параметры инфраструктуры
variable "platform_id" { type = string; default = "standard-v3" }
variable "disk_type" { type = string; default = "network-hdd" }
variable "image_family" { type = string; default = "ubuntu-2004-lts" }
variable "core_fraction" { type = number; default = 20 }
variable "enable_nat" { type = bool; default = true }
variable "ssh_key_path" { type = string; default = "~/.ssh/id_rsa.pub" }

### Количество ресурсов (вынесено из count)
variable "web_count" { type = number; default = 2 }
variable "storage_disk_count" { type = number; default = 3 }

### Конфигурация Web-ВМ
variable "web_cores" { type = number; default = 2 }
variable "web_memory" { type = number; default = 1 }
variable "web_disk_size" { type = number; default = 10 }

### Конфигурация DB-ВМ
variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    { vm_name = "main",    cpu = 4, ram = 8,  disk_volume = 50 },
    { vm_name = "replica", cpu = 2, ram = 4,  disk_volume = 50 }
  ]
}

### Конфигурация Storage-ВМ
variable "storage_cores" { type = number; default = 2 }
variable "storage_memory" { type = number; default = 2 }
variable "storage_boot_disk_size" { type = number; default = 10 }
variable "extra_disk_size" { type = number; default = 1 }