# local gateways
resource "azurerm_local_network_gateway" "lgw" {
  for_each = var.local_gateways

  resource_group_name = var.resourcegroup
  location            = var.location

  name            = try(each.value.name, join("-", [var.naming.local_network_gateway, each.key]))
  gateway_fqdn    = try(each.value.gateway_fqdn, null)
  address_space   = try(each.value.address_space, null)
  gateway_address = try(each.value.gateway_address, "12.13.14.15")
  tags            = try(each.value.tags, var.tags, null)
}

# connections
resource "azurerm_virtual_network_gateway_connection" "example" {
  for_each = var.local_gateways

  resource_group_name = var.resourcegroup
  location            = var.location

  name                       = try(each.value.connection.name, join("-", [var.naming.virtual_network_gateway_connection, each.key]))
  type                       = try(each.value.connection.type, "IPsec")
  virtual_network_gateway_id = try(each.value.connection.virtual_network_gateway_id, var.virtual_network_gateway_id)
  local_network_gateway_id   = azurerm_local_network_gateway.lgw[each.key].id
  shared_key                 = each.value.connection.shared_key
  enable_bgp                 = try(each.value.connection.enable_bgp, false)
  routing_weight             = try(each.value.connection.routing_weight, null)
  connection_mode            = try(each.value.connection.connection_mode, "Default")
  authorization_key          = try(each.value.connection.authorization_key, null)
  connection_protocol        = try(each.value.connection.connection_protocol, "IKEv2")
  express_route_circuit_id   = try(each.value.connection.express_route_circuit_id, null)
  egress_nat_rule_ids        = try(each.value.connection.egress_nat_rule_ids, null)
  ingress_nat_rule_ids       = try(each.value.connection.ingress_nat_rule_ids, null)
  tags                       = try(each.value.connection.tags, var.tags, null)
}
