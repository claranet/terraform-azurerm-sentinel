output "sentinel" {
  description = "Azure Sentinel output object"
  value       = azurerm_sentinel_data_connector_azure_security_center.sentinel
}

output "id" {
  description = "Azure Sentinel ID"
  value       = azurerm_sentinel_data_connector_azure_security_center.sentinel.id
}

output "name" {
  description = "Azure Sentinel name"
  value       = azurerm_sentinel_data_connector_azure_security_center.sentinel.name
}

output "identity_principal_id" {
  description = "Azure Sentinel system identity principal ID"
  value       = try(azurerm_sentinel_data_connector_azure_security_center.sentinel.identity[0].principal_id, null)
}
