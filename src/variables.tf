### Основные переменные YC
variable "token" {
  type        = string
  sensitive   = true
  description = "OAuth-token"
}

variable "cloud_id" {
  type        = string
  description = "Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Folder ID"
}

### Сетевые переменные
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC name"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "CIDR blocks"
}

### Глобальные параметры инфраструктуры
variable "platform_id" {
  type        = string
  default     = "standard-v3"
  description = "VM platform"
}

variable "disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Disk type"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image family"
}

variable "core_fraction" {
  type        = number
  default     = 20
  description = "CPU core fraction"
}

variable "enable_nat" {
  type        = bool
  default     = true
  description = "Enable external IP"
}

variable "ssh_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to SSH public key"
}

### Количество ресурсов
variable "web_count" {
  type        = number
  default     = 2
  description = "Number of web VMs"
}

variable "storage_disk_count" {
  type        = number
  default     = 3
  description = "Number of extra disks"
}

### Конфигурация Web-ВМ
variable "web_cores" {
  type    = number
  default = 2
}
variable "web_memory" {
  type    = number
  default = 1
}
variable "web_disk_size" {
  type    = number
  default = 10
}

### Конфигурация DB-ВМ
variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    { vm_name = "main", cpu = 4, ram = 8, disk_volume = 50 },
    { vm_name = "replica", cpu = 2, ram = 4, disk_volume = 50 }
  ]
}

### Конфигурация Storage-ВМ
variable "storage_cores" {
  type    = number
  default = 2
}
variable "storage_memory" {
  type    = number
  default = 2
}
variable "storage_boot_disk_size" {
  type    = number
  default = 10
}
variable "extra_disk_size" {
  type    = number
  default = 1
}