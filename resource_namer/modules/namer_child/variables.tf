variable "base_name" {
  description = "Base name for the naming convention."
  type        = string
}

variable "resource_type" {
  description = "Resource type: Only allow the values of virtual_machine, key_vault, and storage_account"
  type        = string

# Validation for resource_type
  validation {
    condition     = contains(["virtual_machine", "key_vault", "storage_account"], var.resource_type)
    error_message = "Invalid resource type. Allowed values are: virtual_machine, key_vault, storage_account."
  }
}