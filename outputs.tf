output "gateway" {
  description = "virtual network gateway details"
  value       = azurerm_virtual_network_gateway.vgw
}

output "ip_configuration_ids" {
  description = "contains virtual network gateway ip configuration ids"
  value = {
    for key, config in var.gateway.ip_configurations : key => {
      name      = config.name
      subnet_id = config.subnet_id
      name = format(
        "/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/virtualNetworkGateways/%s/ipConfigurations/%s",
        data.azurerm_subscription.current.subscription_id,
        var.gateway.resourcegroup,
        var.gateway.name,
        config.name
      )
    }
  }
}
