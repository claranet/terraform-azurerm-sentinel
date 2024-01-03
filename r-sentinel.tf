resource "azurerm_sentinel_data_connector_azure_security_center" "sentinel" {
  name = local.sentinel_name

  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(local.default_tags, var.extra_tags)
}
