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
    address_prefixes     = [cidrsubnet(var.virtual_network_address_space,8,index(tolist(var.subnet_names),each.key))]
    depends_on = [ 
        azurerm_virtual_network.network 
    ]
}

resource "azurerm_subnet" "bastionsubnet" {
    count = var.bastion_required ? 1 : 0 
    name = "AzureBastionSubnet"
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes     = ["10.0.10.0/24"]
    depends_on = [ 
        azurerm_virtual_network.network 
    ]
}

resource "azurerm_public_ip" "bastionip" {
    count = var.bastion_required ? 1 : 0 
    name = "bastion-ip"
    resource_group_name  = var.resource_group_name
    location = var.location
    allocation_method = "Static"
    sku = "Standard"
    depends_on = [ 
        module.general_module.resource_group
    ]
}

resource "azurerm_bastion_host" "appbastion" {
    count = var.bastion_required ? 1 : 0 
    name = "appbastion"
    resource_group_name  = var.resource_group_name
    location = var.location

    ip_configuration {
      name = "configuration"
      subnet_id = azurerm_subnet.bastionsubnet[0].id
      public_ip_address_id = azurerm_public_ip.bastionip[0].id
    }
}

