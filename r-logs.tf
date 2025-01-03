module "diagnostic_settings" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "~> 7.0.0"

  resource_id = format("%s/providers/Microsoft.SecurityInsights/settings/SentinelHealth", var.log_analytics_workspace_id)

  logs_destinations_ids = var.logs_destinations_ids
  log_categories        = var.logs_categories
  metric_categories     = var.logs_metrics_categories

  use_caf_naming = var.use_caf_naming
  custom_name    = var.custom_diagnostic_settings_name
  name_prefix    = var.name_prefix
  name_suffix    = var.name_suffix
}
