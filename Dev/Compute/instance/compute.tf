data "terraform_remote_state" "instance" {
  backend = "gcs"
  config = {
    bucket = "newacceleration"
    prefix = "dev/instance"
  }
}

module "instance_template" {
  source          = "../../modules/template"
  region          = var.region
  project_id      = var.project_id
  subnetwork      = var.subnetwork
  service_account = var.service_account
  tags            = var.tags
  labels          = var.labels
  metadata = {


    #!/bin/bash
    startup_script = <<SCRIPT
# package updates

sudo apt update -y
sudo apt install apache2 -y
sudo systemctl status apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo ufw allow 80/tcp
sudo ufw status

# creating the html landing page
cd /var/www/html/
echo '<!DOCTYPE html>' > index.html
echo '<html>' >> index.html
echo '<head>' >> index.html
echo '<title>Level It Up</title>' >> index.html
echo '<meta charset="UTF-8">' >> index.html
echo '</head>' >> index.html
echo '<body>' >> index.html
echo '<h1>Level Up New Acceleration</h1>' >> index.html
echo '<h3>Web Team</h3>' >> index.html
echo '</body>' >> index.html
echo '</html>' >> index.html

sudo systemctl restart apache2
SCRIPT

  }
}

module "compute_instance" {
  source              = "../../modules/compute"
  region              = var.region
  zone                = var.zone
  subnetwork          = var.subnetwork
  num_instances       = var.num_instances
  hostname            = "webserver"
  instance_template   = module.instance_template.self_link
  deletion_protection = false
}