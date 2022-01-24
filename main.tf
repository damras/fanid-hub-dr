# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.91"
    }
  }

  required_version = ">= 1.0"
}

provider "azurerm" {

  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
   }
}

data "azurerm_client_config" "current" {}

output "current_client_id" {
  value = data.azurerm_client_config.current.client_id
}

output "current_tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "current_subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "current_object_id" {
  value = data.azurerm_client_config.current.object_id
}

module "firewall" {
   source                = "./firewall"
   rg-name               = var.rg-name
   rg-location           = var.rg-location
   location-prefix       = var.location-prefix
   firewall-subnet-id      = var.firewall-subnet-id
   la-workspace-id       = var.la-workspace-id
   customer-name         = var.customer-name
   env                   = var.env
   createdby             = var.createdby
   creationdate          = var.creationdate
   aks-subnet-address-space = var.aks-subnet-address-space
}
