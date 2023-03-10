module "new-acceleration-subnets" {
  source = "../modules/vpc/subnets"

  project_id   = var.project_id
  network_name = var.network_name
  subnets      = var.subnets

}