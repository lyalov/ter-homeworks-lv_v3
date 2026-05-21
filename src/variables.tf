variable "token" {
  type        = string
  description = "IAM-токен Яндекс Облака"
}

variable "cloud_id" {
  type        = string
  description = "ID облака"
}

variable "folder_id" {
  type        = string
  description = "ID папки"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Зона доступности"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "Имя сети и подсети"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "CIDR подсети"
}

# --- Параметры инфраструктуры  ---
variable "platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Платформа ВМ"
}

variable "disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Тип диска"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство образа ОС"
}

variable "core_fraction" {
  type        = number
  default     = 20
  description = "Доля CPU"
}

variable "enable_nat" {
  type        = bool
  default     = true
  description = "Выдавать ли внешний IP"
}

variable "ssh_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Путь к публичному SSH-ключу"
}

# --- Web серверы ---
variable "web_count" {
  type        = number
  default     = 2
  description = "Количество веб-серверов"
}

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

# --- Базы данных ---
variable "db_config" {
  type = list(object({
    vm_name = string
    cpu     = number
    ram     = number
    disk    = number
  }))
  default = [
    { vm_name = "main", cpu = 4, ram = 8, disk = 50 },
    { vm_name = "replica", cpu = 2, ram = 4, disk = 50 }
  ]
  description = "Конфигурация ВМ баз данных"
}

# --- Storage сервер ---
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

variable "extra_disk_count" {
  type        = number
  default     = 3
  description = "Количество дополнительных дисков"
}

variable "extra_disk_size" {
  type        = number
  default     = 1
  description = "Размер дополнительных дисков (Гб)"
}