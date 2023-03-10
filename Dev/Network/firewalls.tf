module "new-acceleration-firewall_rules" {
  source = "../modules/vpc/firewalls"

  project_id   = var.project_id
  network_name = module.new-acceleration-host-vpc.network_name
  rules        = var.firewall_rules

}