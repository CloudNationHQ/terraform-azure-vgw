resource "azurerm_virtual_network_gateway_nat_rule" "rules" {
  for_each = var.rules

  name                       = try(each.value.name, each.key)
  mode                       = each.value.mode
  type                       = each.value.type
  virtual_network_gateway_id = try(each.value.virtual_network_gateway_id, var.virtual_network_gateway_id)
  ip_configuration_id        = each.value.ip_configuration_id
  resource_group_name        = var.resourcegroup

  external_mapping {
    address_space = each.value.external_mappings.address_space
    port_range    = try(each.value.external_mappings.port_range, null)
  }

  internal_mapping {
    address_space = each.value.internal_mappings.address_space
    port_range    = try(each.value.internal_mappings.port_range, null)
  }
}
