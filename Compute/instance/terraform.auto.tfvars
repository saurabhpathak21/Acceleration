project_id = "new-acceleration-364810"
region     = "europe-west2"
zone       = "europe-west2-a"
labels = {
  "name" : "dev-webserver-template"
}

tags = ["allow-ssh-ingress", "allow-https-ingress", "egress-internet"]

service_account = {
  email  = "689056015956-compute@developer.gserviceaccount.com"
  scopes = ["cloud-platform"]
}

subnetwork    = "projects/new-acceleration-364810/regions/europe-west2/subnetworks/public-subnet"
num_instances = 1 