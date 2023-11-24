resource "azurerm_resource_group" "vm-rg1" {
  name     = var.resource_group_name
  location = var.location
}

