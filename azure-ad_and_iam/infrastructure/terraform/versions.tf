# https://www.terraform.io/docs/language/settings/index.html
# https://www.terraform.io/docs/language/expressions/version-constraints.html
terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.43"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.33"
    }
  }
  required_version = "~> 1.3"
}
