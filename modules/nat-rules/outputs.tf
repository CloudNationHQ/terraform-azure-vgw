output "rules" {
  description = "contains all nat rules"
  value = {
    for k, rules in azurerm_virtual_network_gateway_nat_rule.rules : k => rules
  }
}
