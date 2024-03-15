<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AZURE Private Dns Resolver
</h1>

<p align="center" style="font-size: 1.2rem;">
    Terraform module to create PRIVATE DNS RESOLVER resource on AZURE.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v1.7.4-green" alt="Terraform">
</a>
<a href="https://github.com/slovink/terraform-azure-private-dns-resolver/blob/dev/LICENSE">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>






## Prerequisites

This module has a few dependencies:

- [Terraform 1.x.x](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/slovink/terraform-azure-private-dns-resolver/releases).


### Simple Example
Here is an example of how you can use this module in your inventory structure:
  ```hcl

module "dns-private-resolver" {
  source              = "git@github.com:slovink/terraform-azure-private-dns-resolver.git?ref=1.0.0"
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
```

## complete
Here is an example of how you can use this module in your inventory structure:
  ```hcl

module "dns-private-resolver" {
source              = "git@github.com:slovink/terraform-azure-private-dns-resolver.git?ref=1.0.0"
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
```
## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/slovink/terraform-azure-private-dns-resolver/blob/master/LICENSE) file for details.

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/slovink/terraform-azure-private-dns-resolver/tree/master/_example) directory within this repository.



## Feedback
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/slovink/terraform-azure-private-dns-resolver/issues), or feel free to drop us an email at [contact@slovink.com](contact@slovink.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/slovink/terraform-azure-private-dns-resolver!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.87.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git@github.com:slovink/terraform-azure-labels.git | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_resolver.private_dns_resolver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver) | resource |
| [azurerm_private_dns_resolver_dns_forwarding_ruleset.forwarding_ruleset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_dns_forwarding_ruleset) | resource |
| [azurerm_private_dns_resolver_inbound_endpoint.private_dns_resolver_inbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_inbound_endpoint) | resource |
| [azurerm_private_dns_resolver_outbound_endpoint.private_dns_resolver_outbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_outbound_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_resolver_inbound_endpoints"></a> [dns\_resolver\_inbound\_endpoints](#input\_dns\_resolver\_inbound\_endpoints) | (Optional): Set of Azure Private DNS resolver Inbound Endpoints | <pre>set(object({<br>    inbound_endpoint_name        = string<br>    private_ip_allocation_method = optional(string, "Dynamic")<br>    inbound_subnet_id            = string<br>    private_ip_address           = optional(string)<br><br>  }))</pre> | `[]` | no |
| <a name="input_dns_resolver_outbound_endpoints"></a> [dns\_resolver\_outbound\_endpoints](#input\_dns\_resolver\_outbound\_endpoints) | (Optional): Set of Azure Private DNS resolver Outbound Endpoints with one or more Forwarding Rule sets | <pre>set(object({<br>    outbound_endpoint_name = string<br>    outbound_subnet_id     = string<br>    forwarding_rulesets = optional(set(object({<br>      forwarding_ruleset_name = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Flag to control the module creation | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `null` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Variable to pass extra tags. | `map(string)` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `null` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/slovink/terraform-azure-private-dns-resolver"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | The name of the virtual network in which the subnet is created in | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_resolver"></a> [dns\_resolver](#output\_dns\_resolver) | n/a |
<!-- END_TF_DOCS -->
