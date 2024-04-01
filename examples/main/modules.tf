module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "sentinel" {
  source  = "claranet/sentinel/azurerm"
  version = "x.x.x"

  log_analytics_workspace_id = module.logs.log_analytics_workspace_id
  logs_destinations_ids      = [module.logs.log_analytics_workspace_id]

  data_connector_aad_enabled = true
  data_connector_mti_enabled = true
}
