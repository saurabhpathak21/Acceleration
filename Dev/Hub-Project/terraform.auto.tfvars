//Org and folder details
billing_account = ""
env             = "dev"
organization_id = ""
folder_id       = ""



//spoke project

spoke_project_id = "new-acceleration-spoke"

// subnets

subnets = [
  {
    subnet_name   = "public-subnet"
    subnet_ip     = "10.0.10.0/24"
    subnet_region = "europe-west2"
  },
  {
    subnet_name           = "private-subnet"
    subnet_ip             = "10.0.20.0/24"
    subnet_region         = "europe-west2"
    subnet_private_access = "true"
  }
]
//firewall rules

firewall_rules = [{
  name                    = "allow-ssh-ingress"
  description             = null
  direction               = "INGRESS"
  priority                = "1000"
  ranges                  = ["0.0.0.0/0"]
  source_tags             = null
  source_service_accounts = null
  target_tags             = ["allow-ssh-ingress"]
  target_service_accounts = null
  allow = [{
    protocol = "tcp"
    ports    = ["22"]
  }]
  deny = []
  log_config = {
    metadata = "INCLUDE_ALL_METADATA"
  }
  },

  {
    name                    = "allow-https-ingress"
    description             = null
    direction               = "INGRESS"
    priority                = "1100"
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["allow-https-ingress"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["443", "80"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }

]