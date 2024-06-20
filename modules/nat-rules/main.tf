resource "azurerm_virtual_network_gateway_nat_rule" "rules" {
  for_each = var.rules

  name                       = try(each.value.name, each.key)
  mode                       = each.value.mode
  type                       = each.value.type
  virtual_network_gateway_id = try(each.value.virtual_network_gateway_id, var.virtual_network_gateway_id)
  # Conditionally assign ip_configuration_id only if the type is "Dynamic"
  ip_configuration_id = each.value.type == "Dynamic" ? each.value.ip_configuration_id : null

  resource_group_name = var.resourcegroup

  external_mapping {
    address_space = each.value.external_mappings.address_space
    port_range    = try(each.value.external_mappings.port_range, null)
  }

  internal_mapping {
    address_space = each.value.internal_mappings.address_space
    port_range    = try(each.value.internal_mappings.port_range, null)
  }
}
