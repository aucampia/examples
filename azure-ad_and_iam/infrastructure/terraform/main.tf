data "azuread_user" "current" {
  user_principal_name = var.azuread_user_principal
}

########################################################################
# Common resources
########################################################################

resource "azurerm_resource_group" "main" {
  name     = "rg-eg-${var.project_key}"
  location = var.azure_location
  tags     = local.azurerm_tags
}

resource "azurerm_storage_account" "main" {
  name                = "steg${var.project_key}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = azurerm_resource_group.main.tags

  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"

  min_tls_version = "TLS1_2"

  # shared_access_key_enabled = false
  is_hns_enabled = true
}

resource "azurerm_role_assignment" "azurerm_storage_account_main_000" {
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_user.current.object_id
}

########################################################################
# AzureAD resources
########################################################################

resource "azuread_application" "a" {
  display_name    = "urn:fdc:aucampia.github.io:20220504:example:azure:ad_and_iam:${var.project_key}"
  identifier_uris = ["urn:fdc:aucampia.github.io:20220504:example:azure:ad_and_iam:${var.project_key}"]
}

resource "azuread_service_principal" "a" {
  application_id = azuread_application.a.application_id
}

resource "azuread_application" "b" {
  display_name    = "urn:fdc:aucampia.github.io:20220504:example:azure:ad_and_iam:${var.project_key}:b"
  identifier_uris = ["urn:fdc:aucampia.github.io:20220504:example:azure:ad_and_iam:${var.project_key}:b"]
}

resource "azuread_service_principal" "b" {
  application_id = azuread_application.b.application_id
}
