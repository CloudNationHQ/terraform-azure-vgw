data "azurerm_subscription" "current" {}

# virtual network gateway
resource "azurerm_virtual_network_gateway" "vgw" {

  resource_group_name = coalesce(
    lookup(
      var.gateway, "resource_group_name", null
    ), var.resource_group_name
  )

  location = coalesce(
    lookup(var.gateway, "location", null
    ), var.location
  )

  name                                  = var.gateway.name
  sku                                   = var.gateway.sku
  type                                  = var.gateway.type
  vpn_type                              = var.gateway.vpn_type
  enable_bgp                            = var.gateway.enable_bgp
  generation                            = var.gateway.generation
  active_active                         = var.gateway.active_active
  dns_forwarding_enabled                = var.gateway.dns_forwarding_enabled
  private_ip_address_enabled            = var.gateway.private_ip_address_enabled
  remote_vnet_traffic_enabled           = var.gateway.remote_vnet_traffic_enabled
  virtual_wan_traffic_enabled           = var.gateway.virtual_wan_traffic_enabled
  ip_sec_replay_protection_enabled      = var.gateway.ip_sec_replay_protection_enabled
  bgp_route_translation_for_nat_enabled = var.gateway.bgp_route_translation_for_nat_enabled
  default_local_network_gateway_id      = var.gateway.default_local_network_gateway_id
  edge_zone                             = var.gateway.edge_zone

  tags = coalesce(
    var.gateway.tags, var.tags
  )

  dynamic "ip_configuration" {
    for_each = var.gateway.ip_configurations

    content {
      name = coalesce(
        ip_configuration.value.name, try(
          join("-", [var.naming.virtual_network_gateway, ip_configuration.key]), null
        ), ip_configuration.key
      )

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
      name = coalesce(
        policy_group.value.name, try(
          policy_group.key, null
        )
      )

      priority   = policy_group.value.priority
      is_default = policy_group.value.is_default

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
      asn         = var.gateway.bgp_settings.asn
      peer_weight = var.gateway.bgp_settings.peer_weight

      dynamic "peering_addresses" {
        for_each = try(
          var.gateway.bgp_settings.peering_addresses, {}
        )

        content {
          apipa_addresses       = peering_addresses.value.apipa_addresses
          ip_configuration_name = peering_addresses.value.ip_configuration_name
        }
      }
    }
  }

  dynamic "custom_route" {
    for_each = try(var.gateway.custom_route, null) != null ? [1] : []

    content {
      address_prefixes = var.gateway.custom_route.address_prefixes
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = try(
      var.gateway.vpn_client_configuration != null ? [var.gateway.vpn_client_configuration] : [], []
    )

    content {
      address_space         = vpn_client_configuration.value.address_space
      aad_issuer            = vpn_client_configuration.value.aad_issuer
      aad_tenant            = vpn_client_configuration.value.aad_tenant
      aad_audience          = vpn_client_configuration.value.aad_audience
      vpn_auth_types        = vpn_client_configuration.value.vpn_auth_types
      radius_server_secret  = vpn_client_configuration.value.radius_server_secret
      vpn_client_protocols  = vpn_client_configuration.value.vpn_client_protocols
      radius_server_address = vpn_client_configuration.value.radius_server_address

      dynamic "revoked_certificate" {
        for_each = try(
          vpn_client_configuration.value.revoked_certificate, {}
        )

        content {
          name       = revoked_certificate.value.name
          thumbprint = revoked_certificate.value.thumbprint
        }
      }

      dynamic "root_certificate" {
        for_each = try(
          vpn_client_configuration.value.root_certificate, {}
        )

        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }
      dynamic "radius_server" {
        for_each = try(
          vpn_client_configuration.value.radius_server, {}
        )

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
        for_each = try(
          vpn_client_configuration.virtual_network_gateway_client_connection, {}
        )

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
    try(lookup(each.value.public_ip, "resource_group_name", null), null),
    lookup(var.gateway, "resource_group_name", null),
    var.resource_group_name
  )

  location = coalesce(
    try(lookup(each.value.public_ip, "location", null), null),
    lookup(var.gateway, "location", null),
    var.location
  )

  name = coalesce(
    each.value.public_ip.name, try(
      join("-", [var.naming.public_ip, each.key]), null
    ), each.key
  )

  allocation_method       = each.value.public_ip.allocation_method
  sku                     = each.value.public_ip.sku
  zones                   = each.value.public_ip.zones
  public_ip_prefix_id     = each.value.public_ip.prefix_id
  sku_tier                = each.value.public_ip.sku_tier
  edge_zone               = each.value.public_ip.edge_zone
  ip_version              = each.value.public_ip.ip_version
  reverse_fqdn            = each.value.public_ip.reverse_fqdn
  domain_name_label       = each.value.public_ip.domain_name_label
  ddos_protection_mode    = each.value.public_ip.ddos_protection_mode
  ddos_protection_plan_id = each.value.public_ip.ddos_protection_plan_id
  idle_timeout_in_minutes = each.value.public_ip.idle_timeout_in_minutes
  ip_tags                 = each.value.public_ip.ip_tags
  domain_name_label_scope = each.value.public_ip.domain_name_label_scope

  tags = try(
    each.value.public_ip.tags, var.tags, null
  )

  # https://github.com/hashicorp/terraform-provider-azurerm/issues/17885
  lifecycle {
    create_before_destroy = true
  }
}
