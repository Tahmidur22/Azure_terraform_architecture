module general_module {
    source = "../general"
    resource_group_name = var.resource_group_name
    location = var.location
}

resource "azurerm_virtual_network" "network" {
    name = var.virtual_network_name
    location = var.location
    resource_group_name = var.resource_group_name
    address_space = [ var.virtual_network_address_space ]
    depends_on = [
        module.general_module.resource_group
    ]
}

resource "azurerm_subnet" "subnets" {
    for_each = var.subnet_names
    name                 = each.key
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes     = [cidrsubnet(var.virtual_network_address_space,8,0)]
    depends_on = [ 
        azurerm_virtual_network.network 
    ]
}


