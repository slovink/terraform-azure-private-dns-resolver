provider "azurerm" {
  features {}
}

locals {
  name        = "app"
  environment = "test"
  label_order = ["name", "environment"]
}

module "resource_group" {
  source      = "git@github.com:slovink/terraform-azure-resource-group.git?ref=1.0.0"
  name        = local.name
  environment = local.environment
  label_order = local.label_order
  location    = "North Europe"
}

module "vnet" {
  source              = "git@github.com:slovink/terraform-azure-vnet.git?ref=1.0.0"
  name                = local.name
  environment         = local.environment
  label_order         = local.label_order
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

module "subnet" {
  source = "git@github.com:slovink/terraform-azure-subnet.git?ref=1.0.0"


  name                 = local.name
  environment          = local.environment
  label_order          = local.label_order
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name

  #subnet
  subnet_names    = ["subnet1"]
  subnet_prefixes = ["10.0.1.0/24"]
  delegation = {
    private_dns_resolver_delegation = [
      {
        name    = "Microsoft.Network/dnsResolvers"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    ]
  }
  # route_table
  enable_route_table = true
  route_table_name   = "pub"
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}

module "dns-private-resolver" {
  source              = "../.."
  name                = local.name
  environment         = local.environment
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  virtual_network_id = module.vnet.vnet_id
  dns_resolver_inbound_endpoints = [
    # There is currently only support for two Inbound endpoints per Private Resolver.
    {
      inbound_endpoint_name = "inbound"
      inbound_subnet_id     = module.subnet.default_subnet_id[0]
    }
  ]
}