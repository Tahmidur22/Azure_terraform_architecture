resource "azurerm_resource_group" "vm-rg" {
  name     = var.resource_group_name
  location = var.location
}

