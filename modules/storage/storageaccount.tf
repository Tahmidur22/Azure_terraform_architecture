resource "azurerm_storage_account" "storageaccount" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = var.storage_account_name
  container_access_type = var.container_access
  depends_on = [ 
    azurerm_storage_account.storageaccount 
    ]
}

resource "azurerm_storage_blob" "blob" {
  for_each = var.blobs
  name                   = each.key
  storage_account_name   = var.storage_account_name
  storage_container_name = var.container_name
  type                   = "Block"
  source                 = "${each.value}${each.key}"
  depends_on = [
    azurerm_storage_container.container 
    ]
}
