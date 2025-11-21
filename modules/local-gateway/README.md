# Local Network Gateway

This submodule demonstrates how to manage local network gateways.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_local_network_gateway.lgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) (resource)
- [azurerm_virtual_network_gateway_connection.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_local_gateways"></a> [local\_gateways](#input\_local\_gateways)

Description: Contains all local gateway configuration

Type:

```hcl
map(object({
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
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: contains the region

Type: `string`

Default: `null`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: contains naming convention

Type: `map(string)`

Default: `null`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: contains the resourcegroup name

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

### <a name="input_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#input\_virtual\_network\_gateway\_id)

Description: contains virtual network gateway id

Type: `string`

Default: `null`

## Outputs

No outputs.
<!-- END_TF_DOCS -->
