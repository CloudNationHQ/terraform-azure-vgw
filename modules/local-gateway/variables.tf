variable "local_gateways" {
  description = "Contains all local gateway configuration"
  type = map(object({
    name                       = optional(string)
    gateway_fqdn               = optional(string)
    address_space              = optional(list(string))
    gateway_address            = optional(string, "12.13.14.15")
    tags                       = optional(map(string))
    virtual_network_gateway_id = optional(string)
    bgp_settings = optional(object({
      asn                 = number
      bgp_peering_address = string
      peer_weight         = optional(number)
    }), null)
    connection = object({
      name                               = optional(string)
      type                               = optional(string, "IPsec")
      virtual_network_gateway_id         = optional(string)
      shared_key                         = string
      enable_bgp                         = optional(bool, false)
      routing_weight                     = optional(number)
      connection_mode                    = optional(string, "Default")
      authorization_key                  = optional(string)
      connection_protocol                = optional(string, "IKEv2")
      express_route_circuit_id           = optional(string)
      egress_nat_rule_ids                = optional(list(string))
      ingress_nat_rule_ids               = optional(list(string))
      use_policy_based_traffic_selectors = optional(bool, false)
      express_route_gateway_bypass       = optional(bool, false)
      local_azure_ip_address_enabled     = optional(bool, false)
      peer_virtual_network_gateway_id    = optional(string)
      private_link_fast_path_enabled     = optional(bool, false)
      dpd_timeout_seconds                = optional(number, 45)
      tags                               = optional(map(string))
      ipsec_policy = optional(object({
        dh_group         = string
        ike_encryption   = string
        ike_integrity    = string
        ipsec_encryption = string
        ipsec_integrity  = string
        pfs_group        = string
        sa_datasize      = optional(number)
        sa_lifetime      = optional(number)
      }), null)
      custom_bgp_addresses = optional(object({
        primary   = string
        secondary = optional(string)
      }), null)
      traffic_selector_policy = optional(map(object({
        local_address_cidrs  = list(string)
        remote_address_cidrs = list(string)
      })), {})
    })
  }))
}

variable "virtual_network_gateway_id" {
  description = "contains virtual network gateway id"
  type        = string
  default     = null
}

variable "location" {
  description = "contains the region"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "contains the resourcegroup name"
  type        = string
  default     = null
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
