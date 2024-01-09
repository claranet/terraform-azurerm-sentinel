resource "azurerm_monitor_aad_diagnostic_setting" "aad_logs" {
  count = var.data_connector_aad_enabled ? 1 : 0

  name                       = "Export-Logs-To-Sentinel"
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.sentinel.workspace_id

  dynamic "enabled_log" {
    for_each = toset(var.data_connector_aad_logs)
    content {
      category = enabled_log.key
      retention_policy {}
    }
  }
}
