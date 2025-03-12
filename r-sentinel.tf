resource "azurerm_sentinel_log_analytics_workspace_onboarding" "main" {
  workspace_id = var.log_analytics_workspace_id
}

moved {
  from = azurerm_sentinel_log_analytics_workspace_onboarding.sentinel
  to   = azurerm_sentinel_log_analytics_workspace_onboarding.main
}