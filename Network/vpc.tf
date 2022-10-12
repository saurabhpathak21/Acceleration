module "new-acceleration-host-vpc" {
  source = "../modules/vpc"

  project_id                             = var.project_id
  auto_create_subnetworks                = var.auto_create_subnetworks
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
  mtu                                    = var.mtu
  network_name                           = var.network_name
  routing_mode                           = var.routing_mode
  shared_vpc_host                        = var.shared_vpc_host

}