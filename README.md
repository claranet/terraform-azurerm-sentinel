# Microsoft Sentinel
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/sentinel/azurerm/)

Azure module to deploy a [Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/overview).

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

module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "sentinel" {
  source  = "claranet/sentinel/azurerm"
  version = "x.x.x"

  log_analytics_workspace_id = modules.logs.log_analytics_workspace_id
  data_connector_aad_enabled = true
}
```

## Providers

| Name | Version |
|------|---------|
| azapi | ~> 1.11.0 |
| azurerm | ~> 3.63 |

## Modules

No modules.

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
| data\_connector\_aad\_enabled | Whether the Azure Active Directory logs are retrieved. | `bool` | `false` | no |
| data\_connector\_aad\_logs | List of Azure Active Directory log category. | `list(string)` | <pre>[<br>  "AuditLogs",<br>  "SignInLogs",<br>  "NonInteractiveUserSignInLogs",<br>  "ServicePrincipalSignInLogs",<br>  "ManagedIdentitySignInLogs",<br>  "ProvisioningLogs",<br>  "ADFSSignInLogs",<br>  "RiskyUsers",<br>  "UserRiskEvents",<br>  "NetworkAccessTrafficLogs",<br>  "RiskyServicePrincipals",<br>  "ServicePrincipalRiskEvents",<br>  "EnrichedOffice365AuditLogs",<br>  "MicrosoftGraphActivityLogs"<br>]</pre> | no |
| log\_analytics\_workspace\_id | The Log Analytics Workspace ID. | `string` | n/a | yes |
| ueba\_data\_sources | List of UEBA (User and Entity Behavior Analytics) data sources. | `list(string)` | <pre>[<br>  "AuditLogs",<br>  "AzureActivity",<br>  "SecurityEvent",<br>  "SigninLogs"<br>]</pre> | no |
| ueba\_enabled | Whether UEBA (User and Entity Behavior Analytics) feature is enabled. | `bool` | `true` | no |
| ueba\_entity\_providers | List of UEBA (User and Entity Behavior Analytics) entity providers. | `list(string)` | <pre>[<br>  "AzureActiveDirectory"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [learn.microsoft.com/en-us/azure/sentinel/overview](https://learn.microsoft.com/en-us/azure/sentinel/overview)
