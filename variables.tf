variable "gateway" {
  description = "Contains all virtual network gateway configuration"
  type = object({
    name                                  = string
    resource_group_name                   = optional(string, null)
    location                              = optional(string, null)
    sku                                   = optional(string, "VpnGw5AZ")
    type                                  = optional(string, "Vpn")
    vpn_type                              = optional(string, "RouteBased")
    enable_bgp                            = optional(bool, false)
    generation                            = optional(string, "Generation2")
    active_active                         = optional(bool, false)
    dns_forwarding_enabled                = optional(bool, false)
    private_ip_address_enabled            = optional(bool, false)
    remote_vnet_traffic_enabled           = optional(bool, false)
    virtual_wan_traffic_enabled           = optional(bool, false)
    ip_sec_replay_protection_enabled      = optional(bool, true)
    bgp_route_translation_for_nat_enabled = optional(bool, false)
    default_local_network_gateway_id      = optional(string, null)
    edge_zone                             = optional(string, null)
    tags                                  = optional(map(string))
    ip_configurations = map(object({
      name                          = optional(string, null)
      subnet_id                     = string
      private_ip_address_allocation = optional(string, "Dynamic")
      public_ip = optional(object({
        name                    = optional(string, null)
        resource_group_name     = optional(string, null)
        location                = optional(string, null)
        allocation_method       = optional(string, "Static")
        sku                     = optional(string, "Standard")
        zones                   = optional(list(string), ["1", "2", "3"])
        prefix_id               = optional(string, null)
        sku_tier                = optional(string, "Regional")
        edge_zone               = optional(string, null)
        ip_version              = optional(string, "IPv4")
        reverse_fqdn            = optional(string, null)
        domain_name_label       = optional(string, null)
        ddos_protection_mode    = optional(string, "VirtualNetworkInherited")
        ddos_protection_plan_id = optional(string, null)
        idle_timeout_in_minutes = optional(number, null)
        ip_tags                 = optional(map(string), null)
        domain_name_label_scope = optional(string, null)
        tags                    = optional(map(string), null)
      }), {})
    }))
    policy_groups = optional(map(object({
      name       = optional(string, null)
      priority   = number
      is_default = optional(bool, false)
      policy_members = optional(map(object({
        name  = string
        value = string
        type  = string
      })), {})
    })), {})
    bgp_settings = optional(object({
      asn         = optional(number, 65515)
      peer_weight = optional(number, null)
      peering_addresses = optional(map(object({
        apipa_addresses       = optional(list(string), null)
        ip_configuration_name = string
      })), {})
    }), null)
    custom_route = optional(object({
      address_prefixes = optional(list(string), [])
    }), null)
    vpn_client_configuration = optional(object({
      address_space         = list(string)
      aad_issuer            = optional(string, null)
      aad_tenant            = optional(string, null)
      aad_audience          = optional(string, null)
      vpn_auth_types        = optional(list(string), null)
      radius_server_secret  = optional(string, null)
      vpn_client_protocols  = optional(list(string), null)
      radius_server_address = optional(string, null)
      revoked_certificate = optional(map(object({
        name       = string
        thumbprint = string
      })), {})
      root_certificate = optional(map(object({
        name             = string
        public_cert_data = string
      })), {})
      radius_server = optional(map(object({
        secret  = string
        score   = number
        address = string
      })), {})
      ipsec_policy = optional(object({
        dh_group                  = string
        pfs_group                 = string
        ike_integrity             = string
        ike_encryption            = string
        ipsec_integrity           = string
        ipsec_encryption          = string
        sa_lifetime_in_seconds    = number
        sa_data_size_in_kilobytes = number
      }), null)
      virtual_network_gateway_client_connection = optional(map(object({
        name               = string
        address_prefixes   = list(string)
        policy_group_names = list(string)
      })), {})
    }), null)
  })
  validation {
    condition     = var.gateway.location != null || var.location != null
    error_message = "location must be provided either in the config object or as a separate variable."
  }

  validation {
    condition     = var.gateway.resource_group_name != null || var.resource_group_name != null
    error_message = "resource group name must be provided either in the config object or as a separate variable."
  }
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
