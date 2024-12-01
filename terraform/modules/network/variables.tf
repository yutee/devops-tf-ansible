variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {}

variable "subnet_prefixes" {
  default = ["10.0.1.0/24"]
}

variable "nsg_name" {}

variable "allowed_ports" {
  type = list(string)
  default = ["22", "80", "443"]
}