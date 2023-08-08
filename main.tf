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
}