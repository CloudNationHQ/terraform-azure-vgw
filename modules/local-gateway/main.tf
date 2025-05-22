# local gateways
resource "azurerm_local_network_gateway" "lgw" {
  for_each = var.local_gateways

  resource_group_name = var.resource_group_name
  location            = var.location

  name = coalesce(
    each.value.name, try(
      join("-", [var.naming.local_network_gateway, each.key]), null
    ), each.key
  )

  gateway_fqdn    = each.value.gateway_fqdn
  address_space   = each.value.address_space
  gateway_address = each.value.gateway_address

  dynamic "bgp_settings" {
    for_each = try(each.value.bgp_settings != null ? [each.value.bgp_settings] : [], [])

    content {
      asn                 = bgp_settings.value.asn
      bgp_peering_address = bgp_settings.value.bgp_peering_address
      peer_weight         = bgp_settings.value.peer_weight
    }
  }

  tags = coalesce(
    each.value.tags, var.tags
  )
}

# connections
resource "azurerm_virtual_network_gateway_connection" "example" {
  for_each = var.local_gateways

  resource_group_name = var.resource_group_name
  location            = var.location

  name = coalesce(
    each.value.connection.name, try(
      join("-", [var.naming.virtual_network_gateway_connection, each.key]), null
    ), each.key
  )

  virtual_network_gateway_id = coalesce(
    try(each.value.connection.virtual_network_gateway_id, null),
    var.virtual_network_gateway_id
  )

  type                               = each.value.connection.type
  local_network_gateway_id           = azurerm_local_network_gateway.lgw[each.key].id
  shared_key                         = each.value.connection.shared_key
  enable_bgp                         = each.value.connection.enable_bgp
  routing_weight                     = each.value.connection.routing_weight
  connection_mode                    = each.value.connection.connection_mode
  authorization_key                  = each.value.connection.authorization_key
  connection_protocol                = each.value.connection.connection_protocol
  express_route_circuit_id           = each.value.connection.express_route_circuit_id
  egress_nat_rule_ids                = each.value.connection.egress_nat_rule_ids
  ingress_nat_rule_ids               = each.value.connection.ingress_nat_rule_ids
  use_policy_based_traffic_selectors = each.value.connection.use_policy_based_traffic_selectors
  express_route_gateway_bypass       = each.value.connection.express_route_gateway_bypass
  local_azure_ip_address_enabled     = each.value.connection.local_azure_ip_address_enabled
  peer_virtual_network_gateway_id    = each.value.connection.peer_virtual_network_gateway_id
  private_link_fast_path_enabled     = each.value.connection.private_link_fast_path_enabled
  dpd_timeout_seconds                = each.value.connection.dpd_timeout_seconds

  tags = coalesce(
    each.value.connection.tags, var.tags
  )

  dynamic "ipsec_policy" {
    for_each = try(each.value.connection.ipsec_policy != null ? [each.value.connection.ipsec_policy] : [], [])

    content {
      dh_group         = ipsec_policy.value.dh_group
      ike_encryption   = ipsec_policy.value.ike_encryption
      ike_integrity    = ipsec_policy.value.ike_integrity
      ipsec_encryption = ipsec_policy.value.ipsec_encryption
      ipsec_integrity  = ipsec_policy.value.ipsec_integrity
      pfs_group        = ipsec_policy.value.pfs_group
    }
  }

  dynamic "custom_bgp_addresses" {
    for_each = try(each.value.connection.custom_bgp_addresses != null ? [each.value.connection.custom_bgp_addresses] : [], [])

    content {
      primary   = custom_bgp_addresses.value.primary
      secondary = custom_bgp_addresses.value.secondary
    }
  }

  dynamic "traffic_selector_policy" {
    for_each = try(
      each.value.connection.traffic_selector_policy, {}
    )

    content {
      local_address_cidrs  = traffic_selector_policy.value.local_address_cidrs
      remote_address_cidrs = traffic_selector_policy.value.remote_address_cidrs
    }
  }
}
