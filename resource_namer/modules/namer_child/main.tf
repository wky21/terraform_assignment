# Variables used for resource naming
locals {
        prefix_vm = "vm-"
        key_vault       = "kv-"
        storage_account = "sa"
        suffix_vm = "-00"
    }


# Performs expressions based on the resource type and char length
locals {
    truncated_resource_name = substr(var.base_name, 0, max(0, 15 - length(local.prefix_vm) - length(local.suffix_vm)))
    resource_name = (
        var.resource_type == "virtual_machine" ? "${local.prefix_vm}${local.truncated_resource_name}${local.suffix_vm}" :
        var.resource_type == "key_vault" ? lower("${local.key_vault}${local.truncated_resource_name}") :
        var.resource_type == "storage_account" ? lower(replace("${local.storage_account}${local.truncated_resource_name}", "-", "")) :
        ""
    )
}