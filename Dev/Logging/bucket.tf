module "logging_bucket" {
  source                   = "../modules/logging/storage"
  project_id               = var.project_id
  storage_bucket_name      = var.storage_bucket_name
  location                 = var.location

}