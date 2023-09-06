provider "null" {
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  features {
  }
}

provider "azuread" {
  tenant_id = var.azure_tenant_id
}
