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

  log_analytics_workspace_id = module.logs.log_analytics_workspace_id
  logs_destinations_ids      = [module.logs.log_analytics_workspace_id]

  data_connector_aad_enabled = true
  data_connector_mti_enabled = true
}
```

## Providers

| Name | Version |
|------|---------|
| azapi | ~> 1.12.0 |
| azurerm | ~> 3.63 |
| time | ~> 0.11 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostic\_settings | claranet/diagnostic-settings/azurerm | ~> 6.5.0 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.ueba](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.ueba_entity](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_monitor_aad_diagnostic_setting.aad_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_aad_diagnostic_setting) | resource |
| [azurerm_sentinel_data_connector_aws_s3.aws_s3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_aws_s3) | resource |
| [azurerm_sentinel_data_connector_microsoft_threat_intelligence.mti](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_microsoft_threat_intelligence) | resource |
| [azurerm_sentinel_log_analytics_workspace_onboarding.sentinel](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_log_analytics_workspace_onboarding) | resource |
| [time_offset.mti](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| data\_connector\_aad\_enabled | Whether the Azure Active Directory logs are retrieved. | `bool` | `false` | no |
| data\_connector\_aad\_logs | List of Azure Active Directory log category. | `list(string)` | <pre>[<br>  "AuditLogs",<br>  "SignInLogs",<br>  "NonInteractiveUserSignInLogs",<br>  "ServicePrincipalSignInLogs",<br>  "ManagedIdentitySignInLogs",<br>  "ProvisioningLogs",<br>  "ADFSSignInLogs",<br>  "RiskyUsers",<br>  "UserRiskEvents",<br>  "NetworkAccessTrafficLogs",<br>  "RiskyServicePrincipals",<br>  "ServicePrincipalRiskEvents",<br>  "EnrichedOffice365AuditLogs",<br>  "MicrosoftGraphActivityLogs"<br>]</pre> | no |
| data\_connector\_aws\_s3\_configuration | List of Azure Active Directory log category. | <pre>map(object({<br>    aws_role_arn      = string<br>    destination_table = string<br>    sqs_urls          = list(string)<br>  }))</pre> | `{}` | no |
| data\_connector\_mti\_enabled | Whether the Microsoft Threat Intelligence Data Connector is enabled. | `bool` | `false` | no |
| data\_connector\_mti\_lookback\_days | Microsoft Threat Intelligence Data lookback days. | `number` | `7` | no |
| log\_analytics\_workspace\_id | The Log Analytics Workspace ID. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formated string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| ueba\_data\_sources | List of UEBA (User and Entity Behavior Analytics) data sources. | `list(string)` | <pre>[<br>  "AuditLogs",<br>  "AzureActivity",<br>  "SecurityEvent",<br>  "SigninLogs"<br>]</pre> | no |
| ueba\_enabled | Whether UEBA (User and Entity Behavior Analytics) feature is enabled. | `bool` | `true` | no |
| ueba\_entity\_providers | List of UEBA (User and Entity Behavior Analytics) entity providers. | `list(string)` | <pre>[<br>  "AzureActiveDirectory"<br>]</pre> | no |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `storage_account_custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [learn.microsoft.com/en-us/azure/sentinel/overview](https://learn.microsoft.com/en-us/azure/sentinel/overview)
