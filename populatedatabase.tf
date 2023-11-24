module "storage_module" {
  source = "./modules/storage"
  resource_group_name=local.resource_group_name
  location=local.location
  storage_account_name="appstore20230311"
  container_name="scripts"
  container_access="blob"
  blobs={
    "01.sql"="./dbscripts/"
    "Script.ps1"="./scripts/"
  }
  depends_on = [
    module.general_module    
  ]
}
