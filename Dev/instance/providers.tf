terraform {
  required_version = ">= 0.13.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "< 5.0, >= 2.12"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "< 5.0, >= 3.45"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-network/v4.1.0"
  }
}
provider "google" {
  region      = "europe-west2"
  alias       = "west"
  credentials = var.secret_1
}

provider "google" {
  region      = "europe-east2"
  alias       = "east"
  credentials = var.secret_2
}