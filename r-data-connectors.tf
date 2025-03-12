resource "azurerm_monitor_aad_diagnostic_setting" "main" {
  count = var.data_connector_aad_enabled ? 1 : 0

  name                       = "Export-Logs-To-Sentinel"
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main.workspace_id

  dynamic "enabled_log" {
    for_each = toset(var.data_connector_aad_logs)
    content {
      category = enabled_log.key
      retention_policy {}
    }
  }
}

moved {
  from = azurerm_monitor_aad_diagnostic_setting.aad_logs
  to   = azurerm_monitor_aad_diagnostic_setting.main
}

resource "azurerm_sentinel_data_connector_aws_s3" "main" {
  for_each = var.data_connector_aws_s3_configuration

  name                       = each.key
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main.workspace_id

  aws_role_arn      = each.value.aws_role_arn
  destination_table = each.value.destination_table
  sqs_urls          = each.value.sqs_urls
}

moved {
  from = azurerm_sentinel_data_connector_aws_s3.aws_s3
  to   = azurerm_sentinel_data_connector_aws_s3.main
}

resource "time_offset" "main" {
  count = var.data_connector_mti_enabled ? 1 : 0

  offset_days = local.mti_lookback_days
}

moved {
  from = time_offset.mti
  to   = time_offset.main
}

resource "azurerm_sentinel_data_connector_microsoft_threat_intelligence" "main" {
  count = var.data_connector_mti_enabled ? 1 : 0

  name                                         = "data-connector-mti"
  log_analytics_workspace_id                   = azurerm_sentinel_log_analytics_workspace_onboarding.main.workspace_id
  microsoft_emerging_threat_feed_lookback_date = time_offset.main[0].rfc3339
}

moved {
  from = azurerm_sentinel_data_connector_microsoft_threat_intelligence.mti
  to   = azurerm_sentinel_data_connector_microsoft_threat_intelligence.main
}
