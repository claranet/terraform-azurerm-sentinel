resource "azapi_resource" "ueba_entity" {
  count = var.ueba_enabled ? 1 : 0

  type      = "Microsoft.SecurityInsights/settings@2023-02-01-preview"
  name      = "EntityAnalytics"
  parent_id = azurerm_sentinel_log_analytics_workspace_onboarding.sentinel.workspace_id

  body = jsonencode({
    kind = "EntityAnalytics"
    properties = {
      entityProviders = var.ueba_entity_providers
    }
  })
}

resource "azapi_resource" "ueba" {
  depends_on = [azapi_resource.ueba_entity]
  count      = var.ueba_enabled ? 1 : 0

  type      = "Microsoft.SecurityInsights/settings@2023-02-01-preview"
  name      = "Ueba"
  parent_id = azurerm_sentinel_log_analytics_workspace_onboarding.sentinel.workspace_id

  body = jsonencode({
    kind = "Ueba"
    properties = {
      dataSources = var.ueba_data_sources
    }
  })
}
