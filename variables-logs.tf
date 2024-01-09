variable "log_analytics_workspace_retention_in_days" {
  description = "The workspace data retention in days. Possible values range between 30 and 730."
  type        = number
  default     = 90
}

variable "logs_storage_account_enabled" {
  description = "Whether the dedicated Storage Account for logs is created."
  type        = bool
  default     = false
}

variable "logs_storage_account_access_tier" {
  description = "Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`."
  type        = string
  default     = "Cool"
}
