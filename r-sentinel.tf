module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "~> 7.8.0"

  client_name    = var.client_name
  location       = var.location
  location_short = var.location_short
  environment    = var.environment
  stack          = var.stack

  resource_group_name = var.resource_group_name

  default_tags_enabled = var.default_tags_enabled
  extra_tags           = var.extra_tags

  log_analytics_workspace_retention_in_days = var.log_analytics_workspace_retention_in_days
  logs_storage_account_enabled              = var.logs_storage_account_enabled
  logs_storage_account_access_tier          = var.logs_storage_account_access_tier
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "sentinel" {
  workspace_id = module.logs.log_analytics_workspace_id
}
