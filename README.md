# Virtual Network Gateway

This terraform module simplifies the process of creating and managing virtual network gateways, local network gateways, and their connections. It offers customizable options and features, providing a flexible solution for integrating vpn functionality.

## Goals

The main objective is to create a more logic data structure, achieved by combining and grouping related resources together in a complex object.

The structure of the module promotes reusability. It's intended to be a repeatable component, simplifying the process of building diverse workloads and platform accelerators consistently.

A primary goal is to utilize keys and values in the object that correspond to the REST API's structure. This enables us to carry out iterations, increasing its practical value as time goes on.

A last key goal is to separate logic from configuration in the module, thereby enhancing its scalability, ease of customization, and manageability.

## Non-Goals

These modules are not intended to be complete, ready-to-use solutions; they are designed as components for creating your own patterns.

They are not tailored for a single use case but are meant to be versatile and applicable to a range of scenarios.

Security standardization is applied at the pattern level, while the modules include default values based on best practices but do not enforce specific security standards.

End-to-end testing is not conducted on these modules, as they are individual components and do not undergo the extensive testing reserved for complete patterns or solutions.

## Features

- supports both active-active and active-passive configurations for enhanced redundancy and availability.
- utilization of terratest for robust validation.
- allows multiple ip configurations.
- enables the configuration of multiple local network gateways and connections.
- optionally allows the addition of NAT rules, enabling customized network address translation.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.pips](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.vgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gateway"></a> [gateway](#input\_gateway) | virtual network gateway details | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | default azure region to be used. | `string` | `null` | no |
| <a name="input_naming"></a> [naming](#input\_naming) | contains naming convention | `map(string)` | `{}` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | default resource group to be used. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to be added to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway"></a> [gateway](#output\_gateway) | virtual network gateway details |
| <a name="output_ip_configuration_ids"></a> [ip\_configuration\_ids](#output\_ip\_configuration\_ids) | contains virtual network gateway ip configuration ids |
<!-- END_TF_DOCS -->

## Testing

As a prerequirement, please ensure that both go and terraform are properly installed on your system.

The [Makefile](Makefile) includes two distinct variations of tests. The first one is designed to deploy different usage scenarios of the module. These tests are executed by specifying the TF_PATH environment variable, which determines the different usages located in the example directory.

To execute this test, input the command ```make test TF_PATH=default```, substituting default with the specific usage you wish to test.

The second variation is known as a extended test. This one performs additional checks and can be executed without specifying any parameters, using the command ```make test_extended```.

Both are designed to be executed locally and are also integrated into the github workflow.

Each of these tests contributes to the robustness and resilience of the module. They ensure the module performs consistently and accurately under different scenarios and configurations.

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

## Authors

Module is maintained by [these awesome contributors](https://github.com/cloudnationhq/terraform-azure-vgw/graphs/contributors).

## Contributing

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md).

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/vpn-gateway/)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/network-gateway/virtual-network-gateways?view=rest-network-gateway-2023-09-01)
- [Rest Api Specs](https://github.com/Azure/azure-rest-api-specs/blob/1f449b5a17448f05ce1cd914f8ed75a0b568d130/specification/network/resource-manager/Microsoft.Network/stable/2022-11-01/virtualNetworkGateway.json)
