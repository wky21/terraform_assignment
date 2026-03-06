# Resource Namer Terraform Modules

This repository contains a parent module (`resource_namer`) and a child module (`namer_child`) for generating consistent and unique resource names in your infrastructure.

## Overview

- **Parent Module:** Iterates over a map of base names and resource types, invoking the child module for each entry.
- **Child Module:** Generates a resource name based on the base name and resource type, applying naming conventions for different resource types.

---

## Module Structure

```
resource_namer/
  main.tf
  outputs.tf
  variables.tf
  README.md
  modules/
    namer_child/
      main.tf
      outputs.tf
      variables.tf
```

---

## Usage

```hcl
variable "resource_map" {
  description = "Map of base name to resource type"
  type        = map(string)
  default     = {
    "webapp" = "virtual_machine"
    "vault"  = "key_vault"
    "store"  = "storage_account"
  }
}

module "resource_namer" {
  source        = "./resource_namer"
  resource_map  = var.resource_map
}

output "resource_names" {
  value = module.resource_namer.resource_names
}
```

---

## Parent Module: `resource_namer`

### Inputs

| Name         | Description                         | Type        | Required |
|--------------|-------------------------------------|-------------|:--------:|
| resource_map | Map of base name to resource type   | map(string) |   yes    |

### Outputs

| Name           | Description                              |
|----------------|------------------------------------------|
| resource_names | Map of base name to generated name(s)    |

---

## Child Module: `namer_child`

### Inputs

| Name          | Description                        | Type   | Required |
|---------------|------------------------------------|--------|:--------:|
| base_name     | The base name for the resource     | string |   yes    |
| resource_type | The type of resource               | string |   yes    |

### Outputs

| Name          | Description                |
|---------------|----------------------------|
| resource_name | Generated resource name    |

---

## Naming Logic

- **virtual_machine:** `vm-<truncated_base_name>-00`
- **key_vault:** `kv-<truncated_base_name>` (lowercase)
- **storage_account:** `sa<truncated_base_name>` (lowercase, hyphens removed)

The base name is truncated as needed to fit naming constraints.

---

## Example Output

```hcl
{
  webapp = {
    resource_name = "vm-webapp-00"
  }
  vault = {
    resource_name = "kv-vault"
  }
  store = {
    resource_name = "sastore"
  }
}
```

---

## License

MIT License