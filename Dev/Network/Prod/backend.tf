terraform {
  backend "gcs" {
    bucket = "newacceleration"
    prefix = "terraform/state"
  }
}