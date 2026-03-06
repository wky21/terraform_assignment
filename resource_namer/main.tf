# Calls the namer_child module for each key value pair in the resource_map variable.

module "namer_child" {
  source        = "../modules/namer_child"
  for_each      = var.resource_map
  base_name     = each.key
  resource_type = each.value
}
