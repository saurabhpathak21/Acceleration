#Create Project

module "spoke-project" {
  source                  = "../modules/project"
  random_project_id       = true
  name                    = var.spoke_project_id
  org_id                  = var.organization_id  #hardcode the value
  billing_account         = var.billing_account  #hardcode the value
  default_service_account = "deprivilege"

#Activate API's
  activate_api_identities = [{
    api = "healthcare.googleapis.com"   # Enable APi's
    roles = [
      "roles/bigquery.jobUser"        
    ]
  }]
}

#Assign Permission

resource "google_project_iam_binding" "project" {
  project = module.spoke-project.project_id
  role    = "roles/editor"
  members = [
    "user:saurabh.pathak@ps.com", "user:test.test@test123.com"
  ]
}


#Shared VPC

locals {
network_name = "${var.env}-acceleration-xpn-001"
}

/******************************************
	VPC configuration
 *****************************************/
module "vpc" {
  source                                 = "../modules/vpc"
  network_name                           = local.network_name
  auto_create_subnetworks                = var.auto_create_subnetworks
  routing_mode                           = var.routing_mode
  project_id                             = var.hub_project_id 
  description                            = var.description
  shared_vpc_host                        = var.shared_vpc_host
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
  mtu                                    = var.mtu
}

//subnets

/******************************************
	Subnet configuration
 *****************************************/
module "subnets" {
  source           = "../modules/vpc/subnets"
  project_id       = var.hub_project_id 
  network_name     = module.vpc.network_name
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}

/******************************************
	Routes
 *****************************************/
module "routes" {
  source            = "../modules/vpc/routes"
  project_id        = var.hub_project_id 
  network_name      = module.vpc.network_name
  routes            = var.routes
  module_depends_on = [module.subnets.subnets]
}

/******************************************
	Firewall rules
 *****************************************/
locals {
  rules = [
    for f in var.firewall_rules : {
      name                    = f.name
      direction               = f.direction
      priority                = lookup(f, "priority", null)
      description             = lookup(f, "description", null)
      ranges                  = lookup(f, "ranges", null)
      source_tags             = lookup(f, "source_tags", null)
      source_service_accounts = lookup(f, "source_service_accounts", null)
      target_tags             = lookup(f, "target_tags", null)
      target_service_accounts = lookup(f, "target_service_accounts", null)
      allow                   = lookup(f, "allow", [])
      deny                    = lookup(f, "deny", [])
      log_config              = lookup(f, "log_config", null)
    }
  ]
}

module "firewall_rules" {
  source       = "../modules/vpc/firewalls"
  project_id   = var.hub_project_id 
  network_name = module.vpc.network_name
  rules        = local.rules
}

//VPN

##To Hub  VPC

module "vpn-ha-to-hub" {
  depends_on = [module.subnets]

  source           = "../modules/vpn_ha"
  project_id       = var.spoke_project_id
  region           = var.region
  network          = module.vpc.network_self_link
  name             = "spoke-to-hub"
  peer_gcp_gateway = module.vpn-ha-to-spoke.self_link
  router_asn       = 64514
  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.1"
        asn     = 64513
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.1.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = null
      shared_secret                   = ""
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.1"
        asn     = 64513
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.2.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = null
      shared_secret                   = ""
    }
  }
}

##To Spoke VPC

module "vpn-ha-to-spoke" {

  depends_on = [module.subnets]

  source           = "../modules/vpn_ha"
  project_id       = var.hub_project_id 
  region           = var.region
  network          = module.vpc.network_self_link
  name             = "hub-to-spoke"
  router_asn       = 64513
  peer_gcp_gateway = module.vpn-ha-to-hub.self_link
  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.2"
        asn     = 64514
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.1.1/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = null
      shared_secret                   = module.vpn-ha-to-hub.random_secret
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.2"
        asn     = 64514
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.2.1/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = null
      shared_secret                   = module.vpn-ha-to-hub.random_secret
    }
  }
}
