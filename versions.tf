terraform {
  required_version = ">= 1.3"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.12.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.63"
    }
  }
}
