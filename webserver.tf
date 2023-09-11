resource "azurerm_network_interface" "webinterface" {
    name    =  "webinterface"
    location = local.location
    resource_group_name = local.resource_group_name

    ip_configuration {
      name = "internal"
      subnet_id = module.networking_module.subnets["web-subnet"].id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.webip.id
    }

    depends_on = [ 
        module.networking_module.virtual_network,
        azurerm_public_ip.webip 
     ]
  
}

resource "azurerm_public_ip" "webip" {
    name = "web-ip"
    resource_group_name = local.resource_group_name
    location = local.location
    allocation_method = "Static"
  
}