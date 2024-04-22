# Virtual Network Gateway Nat Rule

This submodule demonstrates how to manage NAT rules on connections.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.61 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.61 |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_gateway_nat_rule.rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_nat_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | contains the region | `string` | `null` | no |
| <a name="input_naming"></a> [naming](#input\_naming) | contains naming convention | `map(string)` | `null` | no |
| <a name="input_resourcegroup"></a> [resourcegroup](#input\_resourcegroup) | contains the resourcegroup name | `string` | `null` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Contains all nat rules | `any` | n/a | yes |
| <a name="input_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#input\_virtual\_network\_gateway\_id) | contains virtual network gateway id | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rules"></a> [rules](#output\_rules) | contains all nat rules |
