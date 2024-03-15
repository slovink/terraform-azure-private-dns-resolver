provider "azurerm" {
  features {}
}

module "dns-private-resolver" {
  source              = "../.."
  name                = "app"
  environment         = "test"
  resource_group_name = "test-rg"
  location            = "North Europe"

  virtual_network_id = "/subscriptions/ 0a7bxxxxxxxxxxxxxxxxx818b5e/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue"
  dns_resolver_inbound_endpoints = [
    # There is currently only support for two Inbound endpoints per Private Resolver.
    {
      inbound_endpoint_name = "inbound"
      inbound_subnet_id     = "/subscriptions/0a7b8xxxxxxxxxxxxxxxxb5e/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnetValue"
    }
  ]
}