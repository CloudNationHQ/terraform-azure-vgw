# Virtual Network Gateway Nat Rule

This submodule demonstrates how to manage NAT rules on connections.

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

- [azurerm_virtual_network_gateway_nat_rule.rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_nat_rule) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_rules"></a> [rules](#input\_rules)

Description: Contains all nat rules

Type:

```hcl
map(object({
    name                       = optional(string, null)
    mode                       = string
    type                       = string
    virtual_network_gateway_id = optional(string, null)
    ip_configuration_id        = optional(string, null)
    external_mappings = object({
      address_space = string
      port_range    = optional(string, null)
    })
    internal_mappings = object({
      address_space = string
      port_range    = optional(string, null)
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

### <a name="input_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#input\_virtual\_network\_gateway\_id)

Description: contains virtual network gateway id

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_rules"></a> [rules](#output\_rules)

Description: contains all nat rules
<!-- END_TF_DOCS -->
