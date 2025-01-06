data "azurerm_subscription" "current" {}

# virtual network gateway
resource "azurerm_virtual_network_gateway" "vgw" {
  name                                  = var.gateway.name
  resource_group_name                   = coalesce(lookup(var.gateway, "resource_group", null), var.resource_group)
  location                              = coalesce(lookup(var.gateway, "location", null), var.location)
  sku                                   = try(var.gateway.sku, "VpnGw5AZ")
  type                                  = try(var.gateway.type, "Vpn")
  vpn_type                              = try(var.gateway.vpn_type, "RouteBased")
  enable_bgp                            = try(var.gateway.enable_bgp, false)
  generation                            = try(var.gateway.generation, "Generation2")
  active_active                         = try(var.gateway.active_active, false)
  dns_forwarding_enabled                = try(var.gateway.dns_forwarding_enabled, false)
  private_ip_address_enabled            = try(var.gateway.private_ip_address_enabled, false)
  remote_vnet_traffic_enabled           = try(var.gateway.remote_vnet_traffic_enabled, false)
  virtual_wan_traffic_enabled           = try(var.gateway.virtual_wan_traffic_enabled, false)
  ip_sec_replay_protection_enabled      = try(var.gateway.ip_sec_replay_protection_enabled, true)
  bgp_route_translation_for_nat_enabled = try(var.gateway.bgp_route_translation_for_nat_enabled, false)
  default_local_network_gateway_id      = try(var.gateway.default_local_network_gateway_id, null)

  tags = try(
    var.gateway.tags, var.tags, null
  )

  dynamic "ip_configuration" {
    for_each = var.gateway.ip_configurations

    content {
      name                 = ip_configuration.value.name
      public_ip_address_id = azurerm_public_ip.pips[ip_configuration.key].id
      subnet_id            = ip_configuration.value.subnet_id

      private_ip_address_allocation = lookup(
        ip_configuration.value, "private_ip_address_allocation", "Dynamic"
      )
    }
  }

  dynamic "policy_group" {
    for_each = try(
      var.gateway.policy_groups, {}
    )

    content {
      name     = policy_group.value.name
      priority = policy_group.value.priority

      dynamic "policy_member" {
        for_each = try(
          policy_group.value.policy_members, {}
        )

        content {
          name  = policy_member.value.name
          value = policy_member.value.value
          type  = policy_member.value.type
        }
      }
    }
  }

  dynamic "bgp_settings" {
    for_each = try(var.gateway.bgp_settings, null) != null ? [1] : []

    content {
      asn         = try(var.gateway.bgp_settings.asn, 65515)
      peer_weight = try(var.gateway.bgp_settings.peer_weight, null)

      dynamic "peering_addresses" {
        for_each = try(var.gateway.bgp_settings.peering_addresses, {})

        content {
          apipa_addresses       = try(peering_addresses.value.apipa_addresses, null)
          ip_configuration_name = peering_addresses.value.ip_configuration_name
        }
      }
    }
  }

  dynamic "custom_route" {
    for_each = try(var.gateway.custom_route, null) != null ? [1] : []

    content {
      address_prefixes = try(var.gateway.custom_route.address_prefixes, [])
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = try(
      var.gateway.vpn_client_configuration != null ? [var.gateway.vpn_client_configuration] : [], []
    )

    content {
      address_space         = vpn_client_configuration.value.address_space
      aad_issuer            = try(vpn_client_configuration.value.aad_issuer, null)
      aad_tenant            = try(vpn_client_configuration.value.aad_tenant, null)
      aad_audience          = try(vpn_client_configuration.value.aad_audience, null)
      vpn_auth_types        = try(vpn_client_configuration.value.vpn_auth_types, null)
      radius_server_secret  = try(vpn_client_configuration.value.radius_server_secret, null)
      vpn_client_protocols  = try(vpn_client_configuration.value.vpn_client_protocols, null)
      radius_server_address = try(vpn_client_configuration.value.radius_server_address, null)

      dynamic "revoked_certificate" {
        for_each = try(vpn_client_configuration.value.revoked_certificate, {})

        content {
          name       = revoked_certificate.value.name
          thumbprint = revoked_certificate.value.thumbprint
        }
      }
      dynamic "root_certificate" {
        for_each = try(vpn_client_configuration.value.root_certificate, {})

        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }
      dynamic "radius_server" {
        for_each = try(vpn_client_configuration.value.radius_server, {})

        content {
          secret  = radius_server.value.secret
          score   = radius_server.value.score
          address = radius_server.value.address
        }
      }
      dynamic "ipsec_policy" {
        for_each = try(
          var.gateway.vpn_client_configuration.ipsec_policy != null ? [var.gateway.vpn_client_configuration.ipsec_policy] : [], []
        )

        content {
          dh_group                  = ipsec_policy.value.dh_group
          pfs_group                 = ipsec_policy.value.pfs_group
          ike_integrity             = ipsec_policy.value.ike_integrity
          ike_encryption            = ipsec_policy.value.ike_encryption
          ipsec_integrity           = ipsec_policy.value.ipsec_integrity
          ipsec_encryption          = ipsec_policy.value.ipsec_encryption
          sa_lifetime_in_seconds    = ipsec_policy.value.sa_lifetime_in_seconds
          sa_data_size_in_kilobytes = ipsec_policy.value.sa_data_size_in_kilobytes
        }
      }
      dynamic "virtual_network_gateway_client_connection" {
        for_each = try(vpn_client_configuration.virtual_network_gateway_client_connection, {})

        content {
          name               = virtual_network_gateway_client_connection.value.name
          address_prefixes   = virtual_network_gateway_client_connection.value.address_prefixes
          policy_group_names = virtual_network_gateway_client_connection.value.policy_group_names
        }
      }
    }
  }
}

resource "azurerm_public_ip" "pips" {
  for_each = var.gateway.ip_configurations

  resource_group_name = coalesce(
    try(lookup(each.value.public_ip, "resource_group", null), null),
    lookup(var.gateway, "resource_group", null),
    var.resource_group
  )

  location = coalesce(
    try(lookup(each.value.public_ip, "location", null), null),
    lookup(var.gateway, "location", null),
    var.location
  )

  name                    = try(each.value.public_ip.name, join("-", [var.naming.public_ip, each.key]))
  allocation_method       = try(each.value.public_ip.allocation_method, "Static")
  sku                     = try(each.value.public_ip.sku, "Standard")
  zones                   = try(each.value.public_ip.zones, [1, 2, 3])
  public_ip_prefix_id     = try(each.value.public_ip.prefix_id, null)
  sku_tier                = try(each.value.public_ip.sku_tier, "Regional")
  edge_zone               = try(each.value.public_ip.edge_zone, null)
  ip_version              = try(each.value.public_ip.ip_version, "IPv4")
  reverse_fqdn            = try(each.value.public_ip.reverse_fqdn, null)
  domain_name_label       = try(each.value.public_ip.domain_name_label, null)
  ddos_protection_mode    = try(each.value.public_ip.ddos_protection_mode, "VirtualNetworkInherited")
  ddos_protection_plan_id = try(each.value.public_ip.ddos_protection_plan_id, null)
  idle_timeout_in_minutes = try(each.value.public_ip.idle_timeout_in_minutes, null)
  ip_tags                 = try(each.value.public_ip.ip_tags, null)
  domain_name_label_scope = try(each.value.public_ip.domain_name_label_scope, null)

  tags = try(
    each.value.public_ip.tags, var.tags, null
  )

  # https://github.com/hashicorp/terraform-provider-azurerm/issues/17885
  lifecycle {
    create_before_destroy = true
  }
}
