variable "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID."
  type        = string
}

variable "data_connector_aad_enabled" {
  description = "Whether the Azure Active Directory logs are retrieved."
  type        = bool
  default     = false
}

variable "data_connector_aad_logs" {
  description = "List of Azure Active Directory log category."
  type        = list(string)
  default     = ["AuditLogs", "SignInLogs", "NonInteractiveUserSignInLogs", "ServicePrincipalSignInLogs", "ManagedIdentitySignInLogs", "ProvisioningLogs", "ADFSSignInLogs", "RiskyUsers", "UserRiskEvents", "NetworkAccessTrafficLogs", "RiskyServicePrincipals", "ServicePrincipalRiskEvents", "EnrichedOffice365AuditLogs", "MicrosoftGraphActivityLogs"]
}

variable "data_connector_mti_enabled" {
  description = "Whether the Microsoft Threat Intelligence Data Connector is enabled."
  type        = bool
  default     = false
}

variable "data_connector_mti_lookback_days" {
  description = "Microsoft Threat Intelligence Data lookback days."
  type        = number
  default     = 7
}

variable "ueba_enabled" {
  description = "Whether UEBA (User and Entity Behavior Analytics) feature is enabled."
  type        = bool
  default     = true
}

variable "ueba_data_sources" {
  description = "List of UEBA (User and Entity Behavior Analytics) data sources."
  type        = list(string)
  default     = ["AuditLogs", "AzureActivity", "SecurityEvent", "SigninLogs"]
}

variable "ueba_entity_providers" {
  description = "List of UEBA (User and Entity Behavior Analytics) entity providers."
  type        = list(string)
  default     = ["AzureActiveDirectory"]
}
