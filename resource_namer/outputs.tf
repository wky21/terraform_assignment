output "resource_names" {
  description = "Map base name to generated resource name"
  value = {
    for base_name, mod in module.namer_child : base_name => mod
  }
}