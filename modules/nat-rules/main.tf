resource "azurerm_virtual_network_gateway_nat_rule" "this" {
  for_each = var.rules

  name = coalesce(
    each.value.name, try(
      each.key, null
    )
  )

  virtual_network_gateway_id = coalesce(
    try(each.value.connection.virtual_network_gateway_id, null),
    var.virtual_network_gateway_id
  )

  # ip_configuration_id is only valid for Dynamic type NAT rules
  ip_configuration_id = each.value.type == "Dynamic" ? each.value.ip_configuration_id : null

  resource_group_name = var.resource_group_name
  mode                = each.value.mode
  type                = each.value.type

  external_mapping {
    address_space = each.value.external_mappings.address_space
    port_range    = each.value.external_mappings.port_range
  }

  internal_mapping {
    address_space = each.value.internal_mappings.address_space
    port_range    = each.value.internal_mappings.port_range
  }
}
