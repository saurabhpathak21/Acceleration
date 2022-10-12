module "new-acceleration-routes" {
  source = "../modules/vpc/routes"

  project_id   = var.project_id
  network_name = var.network_name
  routes       = var.routes
}