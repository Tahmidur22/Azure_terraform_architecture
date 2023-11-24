variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "vm-rg1"
}

variable "location" {
  description = "Name of the location of the Azure resource group"
  type        = string
}