module "log_export" {
  source                 = "terraform-google-modules/log-export/google"


  destination_uri        = "storage.googleapis.com/${var.storage_bucket_name}"
  filter                 = "severity >= ERROR"
  log_sink_name          = "storage_logsink"
  parent_resource_id     = var.project_id
  parent_resource_type   = "project"
  unique_writer_identity = true
}

