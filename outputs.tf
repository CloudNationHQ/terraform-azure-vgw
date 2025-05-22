output "gateway" {
  description = "Contains all virtual network gateway configuration"
  value       = azurerm_virtual_network_gateway.vgw
}

output "ip_configuration_ids" {
  description = "contains virtual network gateway ip configuration ids"
  value = {
    for key, config in var.gateway.ip_configurations : key => {
      subnet_id = config.subnet_id
      name = format(
        "/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/virtualNetworkGateways/%s/ipConfigurations/%s",
        data.azurerm_subscription.current.subscription_id,
        var.gateway.resource_group_name,
        var.gateway.name,
        coalesce(
          config.name, key
        )
      )
    }
  }
}

# output "ip_configuration_ids" {
#   description = "contains virtual network gateway ip configuration ids"
#   value = {
#     for key, config in var.gateway.ip_configurations : key => {
#       name      = config.name
#       subnet_id = config.subnet_id
#       name = format(
#         "/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/virtualNetworkGateways/%s/ipConfigurations/%s",
#         data.azurerm_subscription.current.subscription_id,
#         var.gateway.resource_group_name,
#         var.gateway.name,
#         config.name
#       )
#     }
#   }
# }
