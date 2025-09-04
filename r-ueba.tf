resource "azapi_resource" "ueba_entity" {
  count = var.ueba_enabled ? 1 : 0

  type      = "Microsoft.SecurityInsights/settings@2025-07-01-preview"
  name      = "EntityAnalytics"
  parent_id = azurerm_sentinel_log_analytics_workspace_onboarding.main.workspace_id

  body = {
    kind = "EntityAnalytics"
    properties = {
      entityProviders = var.ueba_entity_providers
    }
  }
}

resource "azapi_resource" "ueba_source" {
  depends_on = [azapi_resource.ueba_entity]
  count      = var.ueba_enabled ? 1 : 0

  type      = "Microsoft.SecurityInsights/settings@2025-07-01-preview"
  name      = "Ueba"
  parent_id = azurerm_sentinel_log_analytics_workspace_onboarding.main.workspace_id

  body = {
    kind = "Ueba"
    properties = {
      dataSources = var.ueba_data_sources
    }
  }
}

moved {
  from = azapi_resource.ueba
  to   = azapi_resource.ueba_source
}
