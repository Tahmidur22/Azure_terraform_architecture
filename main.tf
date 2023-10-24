module "general_module" {
    source= "./modules /general"
    resource_group_name = local.resource_group_name
    location = local.location
}

module "networking_module" {
    source="./modules /networking"
    resource_group_name = local.resource_group_name
    location = local.location
    virtual_network_name = "staging-network"
    virtual_network_address_space = "10.0.0.0/16"
    subnet_names = ["web-subnet", "db-subnet"]
    bastion_required = true
    network-security_group_names={
        "web-nsg"="web-subnet"
        "db-nsg"="db-subnet"
    }

    network_security_group_rules = [{
        id = 1,
        priority = "200",
        network_security_group_name = "web-nsg"
        destination_port_range = "3389"
        access = "Allow"
    },
    {
        id = 2,
        priority = "300",
        network_security_group_name = "web-nsg"
        destination_port_range = "80"
        access = "Allow"
    },
    {
        id = 3,
        priority = "400",
        network_security_group_name = "web-nsg"
        destination_port_range = "8172"
        access = "Allow"
    }, 
    {
        id = 4,
        priority = "200",
        network_security_group_name = "db-nsg"
        destination_port_range = "3389"
        access = "Allow"
    }]
}

module "compute_module" {
    source = "./modules /compute"
    resource_group_name = local.resource_group_name
    location = local.location
    network_interface_name = "db-interface"
    subnet_id=module.networking_module.subnets["db-subnet"].id
    virtual_machine_name="dbvm"
    admin_username = "dbuser"
    admin_password = "AzureDB@Pass"
    source_image_reference = {
        publisher = "MicrosoftSQLServer"
        offer     = "sql2019-ws2019"
        sku       = "sqldev"
        version   = "latest"
    }
    depends_on = [ 
        module.networking_module 
    ]
}

resource "azurerm_mssql_virtual_machine" "mssqlvm" {
  virtual_machine_id               = module.compute_module.vm.id
  sql_license_type                 = "PAYG"
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
  sql_connectivity_update_password = "Azure@12!"
  sql_connectivity_update_username = "sqladmin"
}