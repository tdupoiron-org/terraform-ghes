# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.91.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}