variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "vm-rg1"
}

variable "location" {
  description = "Name of the location of the Azure virtual network"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the Azure virtual network"
  type        = string
}

variable "virtual_network_address_space" {
  description = "The address of the Azure virtual network"
  type        = string
}

variable subnet_names {
  description = "Subnets within the virtual networks"
  type        = set(string)
}

variable "bastion_required" {
  description = "This defines wheather the bastion service is required"
  type        = bool
  default = false
}

variable network-security_group_names {
  description = "This defines the names of the network security groups"
  type        = set(string)
}
