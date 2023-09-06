# https://www.terraform.io/docs/language/values/variables.html

variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "azure_location" {
  type        = string
  description = "Azure location"
}

variable "azuread_user_principal" {
  description = "The name of the Azure AD user principal that is runing the example."
  type = string
}

variable "project_key" {
  description = "A string used to generate unique resource names that don't conflict with existing resources."
  type = string
}
