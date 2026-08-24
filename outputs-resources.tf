output "resource" {
  description = "The Sentinel log analytics workspace onboarding resource."
  value       = azurerm_sentinel_log_analytics_workspace_onboarding.main
}

output "id" {
  description = "The Sentinel log analytics workspace onboarding ID."
  value       = azurerm_sentinel_log_analytics_workspace_onboarding.main.id
}

output "workspace_id" {
  description = "The Log Analytics Workspace ID used for Sentinel onboarding."
  value       = azurerm_sentinel_log_analytics_workspace_onboarding.main.workspace_id
}

output "resource_monitor_aad_diagnostic_setting" {
  description = "The Azure AD diagnostic setting resource for Sentinel data connector."
  value       = azurerm_monitor_aad_diagnostic_setting.main
}

output "resource_sentinel_data_connector_aws_s3" {
  description = "The AWS S3 Sentinel data connector resources."
  value       = azurerm_sentinel_data_connector_aws_s3.main
}

output "resource_sentinel_data_connector_mti" {
  description = "The Microsoft Threat Intelligence Sentinel data connector resource."
  value       = azurerm_sentinel_data_connector_microsoft_threat_intelligence.main
}

output "resource_data_connector_mxdr" {
  description = "The Microsoft XDR data connector resource."
  value       = azapi_resource.data_connector_mxdr
}

output "resource_ueba_entity" {
  description = "The UEBA entity analytics resource."
  value       = azapi_resource.ueba_entity
}

output "resource_ueba_source" {
  description = "The UEBA source resource."
  value       = azapi_resource.ueba_source
}

output "resource_time_offset" {
  description = "The time offset resource used for MTI lookback."
  value       = time_offset.main
}
