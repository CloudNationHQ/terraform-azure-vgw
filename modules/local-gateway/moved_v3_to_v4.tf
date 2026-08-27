moved {
  from = azurerm_local_network_gateway.lgw
  to   = azurerm_local_network_gateway.this
}

moved {
  from = azurerm_virtual_network_gateway_connection.example
  to   = azurerm_virtual_network_gateway_connection.this
}
