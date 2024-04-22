# Local Network Gateway

This submodule demonstrates how to manage local network gateways.

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
| [azurerm_local_network_gateway.lgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_local_gateways"></a> [local\_gateways](#input\_local\_gateways) | contains local gateway configuration | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | contains the region | `string` | `null` | no |
| <a name="input_naming"></a> [naming](#input\_naming) | contains naming convention | `map(string)` | `null` | no |
| <a name="input_resourcegroup"></a> [resourcegroup](#input\_resourcegroup) | contains the resourcegroup name | `string` | `null` | no |
| <a name="input_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#input\_virtual\_network\_gateway\_id) | contains virtual network gateway id | `string` | `null` | no |
