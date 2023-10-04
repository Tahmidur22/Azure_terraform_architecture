terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.41.0"
    }
  }
}

provider "azurerm" {
  features {}  
  subscription_id = "03bec0c9-0af7-49a9-8d8c-756e4f4a4f79"
  tenant_id = ""
  client_id = ""
  client_secret = ""

  //az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/03bec0c9-0af7-49a9-8d8c-756e4f4a4f79"
}