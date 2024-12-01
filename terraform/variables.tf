variable "resource_group_name" {
  description = "The name of the existing resource group in which resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure location where resources will be provisioned."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "ssh_key_path" {
  description = "The path to the SSH public key used to access the virtual machine."
  type        = string
}