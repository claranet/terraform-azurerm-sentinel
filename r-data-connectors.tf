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

resource "time_offset" "mti" {
  count = var.data_connector_mti_enabled ? 1 : 0

  offset_days = local.mti_lookback_days
}

resource "azurerm_sentinel_data_connector_microsoft_threat_intelligence" "mti" {
  count = var.data_connector_mti_enabled ? 1 : 0

  name                                         = "data-connector-mti"
  log_analytics_workspace_id                   = azurerm_sentinel_log_analytics_workspace_onboarding.sentinel.workspace_id
  microsoft_emerging_threat_feed_lookback_date = time_offset.mti[0].rfc3339
}
