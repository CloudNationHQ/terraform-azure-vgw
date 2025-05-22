# Virtual Network Gateway

This terraform module simplifies the process of creating and managing virtual network gateways, local network gateways, and their connections. It offers customizable options and features, providing a flexible solution for integrating vpn functionality.

## Features

Supports both active-active and active-passive configurations for enhanced redundancy and availability.

Utilization of terratest for robust validation.

Allows multiple ip configurations.

Enables the configuration of multiple local network gateways and connections.

Optionally allows the addition of NAT rules, enabling customized network address translation.

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

- [azurerm_public_ip.pips](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) (resource)
- [azurerm_virtual_network_gateway.vgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) (resource)
- [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_gateway"></a> [gateway](#input\_gateway)

Description: Contains all virtual network gateway configuration

Type:

```hcl
object({
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
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: contains naming convention

Type: `map(string)`

Default: `{}`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_gateway"></a> [gateway](#output\_gateway)

Description: Contains all virtual network gateway configuration

### <a name="output_ip_configuration_ids"></a> [ip\_configuration\_ids](#output\_ip\_configuration\_ids)

Description: contains virtual network gateway ip configuration ids
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-vgw/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-vgw" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/vpn-gateway/)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/network-gateway/virtual-network-gateways?view=rest-network-gateway-2023-09-01)
- [Rest Api Specs](https://github.com/Azure/azure-rest-api-specs/blob/1f449b5a17448f05ce1cd914f8ed75a0b568d130/specification/network/resource-manager/Microsoft.Network/stable/2022-11-01/virtualNetworkGateway.json)
