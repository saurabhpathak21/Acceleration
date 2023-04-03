locals {
  routers = {
    "router-1" = {
      name   = "my-router-1"
      region = "europe-west2"
      bgp = {
      asn = "65002" }
      project = "my-project-id-1"
    network = "my-network" }

    "router-2" = {
      name   = "my-router-2"
      region = "europe-west2"
      bgp = {
      asn = "65002" }
      project = "my-project-id-2"
  network = "my-network-2" } }
}


module "cloud_router" {
  source   = "terraform-google-modules/cloud-router/google"
  version  = "5.0.0"
  for_each = local.routers
  name     = each.key
  project  = each.value.project
  region   = each.value.region
  network  = each.value.network
}