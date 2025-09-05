# Microsoft Sentinel
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/sentinel/azurerm/)

Azure module to deploy a [Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/overview).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name
}

module "sentinel" {
  source  = "claranet/sentinel/azurerm"
  version = "x.x.x"

  log_analytics_workspace_id = module.logs.id
  logs_destinations_ids      = [module.logs.id]

  data_connector_aad_enabled = true
  data_connector_mti_enabled = true
}
```

## Providers

| Name | Version |
|------|---------|
| azapi | ~> 2.0 |
| azurerm | ~> 4.31 |
| time | ~> 0.13 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 8.2.0 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.data_connector_mxdr](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.ueba_entity](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.ueba_source](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_monitor_aad_diagnostic_setting.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_aad_diagnostic_setting) | resource |
| [azurerm_sentinel_data_connector_aws_s3.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_aws_s3) | resource |
| [azurerm_sentinel_data_connector_microsoft_threat_intelligence.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_microsoft_threat_intelligence) | resource |
| [azurerm_sentinel_log_analytics_workspace_onboarding.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_log_analytics_workspace_onboarding) | resource |
| [time_offset.main](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_tenant\_id | Azure tenant ID. | `string` | `""` | no |
| data\_connector\_aad\_enabled | Whether the Azure Active Directory logs are retrieved. | `bool` | `false` | no |
| data\_connector\_aad\_logs | List of Azure Active Directory log category. | `list(string)` | <pre>[<br/>  "AuditLogs",<br/>  "SignInLogs",<br/>  "NonInteractiveUserSignInLogs",<br/>  "ServicePrincipalSignInLogs",<br/>  "ManagedIdentitySignInLogs",<br/>  "ProvisioningLogs",<br/>  "ADFSSignInLogs",<br/>  "RiskyUsers",<br/>  "UserRiskEvents",<br/>  "NetworkAccessTrafficLogs",<br/>  "RiskyServicePrincipals",<br/>  "ServicePrincipalRiskEvents",<br/>  "EnrichedOffice365AuditLogs",<br/>  "MicrosoftGraphActivityLogs"<br/>]</pre> | no |
| data\_connector\_aws\_s3\_configuration | List of Azure Active Directory log category. | <pre>map(object({<br/>    aws_role_arn      = string<br/>    destination_table = string<br/>    sqs_urls          = list(string)<br/>  }))</pre> | `{}` | no |
| data\_connector\_mti\_enabled | Whether the Microsoft Threat Intelligence Data Connector is enabled. | `bool` | `false` | no |
| data\_connector\_mti\_lookback\_days | Microsoft Threat Intelligence Data lookback days. | `number` | `7` | no |
| data\_connector\_mxdr\_enabled | Whether sync is enabled between Microsoft XDR incidents and Microsoft Sentinel. | `bool` | `false` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be `default` if not set. | `string` | `"default"` | no |
| log\_analytics\_workspace\_id | The Log Analytics Workspace ID. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| ueba\_data\_sources | List of UEBA (User and Entity Behavior Analytics) data sources. | `list(string)` | <pre>[<br/>  "AuditLogs",<br/>  "AzureActivity",<br/>  "SecurityEvent",<br/>  "SigninLogs"<br/>]</pre> | no |
| ueba\_enabled | Whether UEBA (User and Entity Behavior Analytics) feature is enabled. | `bool` | `true` | no |
| ueba\_entity\_providers | List of UEBA (User and Entity Behavior Analytics) entity providers. | `list(string)` | <pre>[<br/>  "AzureActiveDirectory"<br/>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [learn.microsoft.com/en-us/azure/sentinel/overview](https://learn.microsoft.com/en-us/azure/sentinel/overview)
