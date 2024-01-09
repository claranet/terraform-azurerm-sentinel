variable "data_connector_aad_enabled" {
  description = "Whether the Azure Active Directory logs are retrieving."
  type        = bool
  default     = false
}

variable "data_connector_aad_logs" {
  description = "List of Azure Active Directory log category."
  type        = list(string)
  default     = ["AuditLogs", "SignInLogs", "NonInteractiveUserSignInLogs", "ServicePrincipalSignInLogs", "ManagedIdentitySignInLogs", "ProvisioningLogs", "ADFSSignInLogs", "RiskyUsers", "UserRiskEvents", "NetworkAccessTrafficLogs", "RiskyServicePrincipals", "ServicePrincipalRiskEvents", "EnrichedOffice365AuditLogs", "MicrosoftGraphActivityLogs"]
}

variable "ueba_enabled" {
  description = "Whether UEBA feature is enabled."
  type        = bool
  default     = true
}

variable "ueba_data_sources" {
  description = "List of UEBA Data Sources."
  type        = list(string)
  default     = ["AuditLogs", "AzureActivity", "SecurityEvent", "SigninLogs"]
}

variable "ueba_entity_providers" {
  description = "List of UEBA Entity Providers."
  type        = list(string)
  default     = ["AzureActiveDirectory"]
}
