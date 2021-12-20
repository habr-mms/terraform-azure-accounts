terraform {
  required_providers {
    azurerm = {
      source  = "registry.terraform.io/hashicorp/azurerm"
      version = "~>2.19"
    }
    azuread = {
      source  = "registry.terraform.io/hashicorp/azuread"
      version = "~>2.5"
    }
  }
  required_version = "~>1.0"
}
