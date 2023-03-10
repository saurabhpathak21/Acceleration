terraform {
  backend "gcs" {
    bucket = "newacceleration"
    prefix = "dev/instance"
  }
}