# Microsoft Sentinel
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/sentinel/azurerm/)

Azure module to deploy a [Microsoft Sentinel](https://docs.microsoft.com/en-us/azure/xxxxxxx).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "sentinel" {
  source  = "claranet/sentinel/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  logs_storage_account_enabled = false
  data_connector_aad_enabled   = true

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| azapi | ~> 1.11.0 |
| azurerm | ~> 3.36 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| logs | claranet/run/azurerm//modules/logs | ~> 7.8.0 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.ueba](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.ueba_entity](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_monitor_aad_diagnostic_setting.aad_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_aad_diagnostic_setting) | resource |
| [azurerm_sentinel_log_analytics_workspace_onboarding.sentinel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_log_analytics_workspace_onboarding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| data\_connector\_aad\_enabled | Whether the Azure Active Directory logs are retrieving. | `bool` | `false` | no |
| data\_connector\_aad\_logs | List of Azure Active Directory log category. | `list(string)` | <pre>[<br>  "AuditLogs",<br>  "SignInLogs",<br>  "NonInteractiveUserSignInLogs",<br>  "ServicePrincipalSignInLogs",<br>  "ManagedIdentitySignInLogs",<br>  "ProvisioningLogs",<br>  "ADFSSignInLogs",<br>  "RiskyUsers",<br>  "UserRiskEvents",<br>  "NetworkAccessTrafficLogs",<br>  "RiskyServicePrincipals",<br>  "ServicePrincipalRiskEvents",<br>  "EnrichedOffice365AuditLogs",<br>  "MicrosoftGraphActivityLogs"<br>]</pre> | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to add on resources. | `map(string)` | `{}` | no |
| location | Azure region to use. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| log\_analytics\_workspace\_retention\_in\_days | The workspace data retention in days. Possible values range between 30 and 730. | `number` | `90` | no |
| logs\_storage\_account\_access\_tier | Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`. | `string` | `"Cool"` | no |
| logs\_storage\_account\_enabled | Whether the dedicated Storage Account for logs is created. | `bool` | `false` | no |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| stack | Project stack name. | `string` | n/a | yes |
| ueba\_data\_sources | List of UEBA Data Sources. | `list(string)` | <pre>[<br>  "AuditLogs",<br>  "AzureActivity",<br>  "SecurityEvent",<br>  "SigninLogs"<br>]</pre> | no |
| ueba\_enabled | Whether UEBA feature is enabled. | `bool` | `true` | no |
| ueba\_entity\_providers | List of UEBA Entity Providers. | `list(string)` | <pre>[<br>  "AzureActiveDirectory"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| log\_analytics\_workspace\_guid | The Log Analytics Workspace GUID. |
| log\_analytics\_workspace\_id | The Log Analytics Workspace ID. |
| log\_analytics\_workspace\_location | The Log Analytics Workspace location. |
| log\_analytics\_workspace\_name | The Log Analytics Workspace name. |
| log\_analytics\_workspace\_primary\_key | The primary shared key for the Log Analytics Workspace. |
| log\_analytics\_workspace\_secondary\_key | The secondary shared key for the Log Analytics Workspace. |
| logs\_resource\_group\_name | Resource Group of the logs resources. |
| logs\_storage\_account\_archived\_logs\_fileshare\_name | Name of the file share in which externalized logs are stored. |
| logs\_storage\_account\_id | ID of the logs Storage Account. |
| logs\_storage\_account\_name | Name of the logs Storage Account. |
| logs\_storage\_account\_primary\_access\_key | Primary connection string of the logs Storage Account. |
| logs\_storage\_account\_primary\_connection\_string | Primary connection string of the logs Storage Account. |
| logs\_storage\_account\_secondary\_access\_key | Secondary connection string of the logs Storage Account. |
| logs\_storage\_account\_secondary\_connection\_string | Secondary connection string of the logs Storage Account. |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: xxxx
