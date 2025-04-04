terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

# configuring  the Azure Provider
provider "azurerm" {
  subscription_id = "8cd818a3-1004-4d7d-b2d2-4e45880cd697"
  tenant_id       = "2e71ef43-0795-4b46-889b-4d6ca854b64d"

  features {

  }
  resource_provider_registrations = "none"
}

# Creating a new resource group
resource "azurerm_resource_group" "new_rg" {
  name     = "new_storage_res_grp"
  location = "East US"
}

# Creating a Storage Account with a new name 
resource "azurerm_storage_account" "new_storage" {
  name                     = "raghavsaxenastorage"
  resource_group_name      = azurerm_resource_group.new_rg.name
  location                 = azurerm_resource_group.new_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "TerraformDemo"
  }
}

# Creating a storage container with a new name

resource "azurerm_storage_container" "new_container" {
  name                  = "newcontainer"
  storage_account_id    = azurerm_storage_account.new_storage.id
  container_access_type = "private"
}