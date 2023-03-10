variable "project_id" {
  description = "The ID of the project in which the log bucket will be created."
  type        = string
}

variable "location" {
  description = "The location of the log bucket."
  type        = string
  default     = "europe-west2"
}

variable "storage_bucket_name" {
  description = "The name of the storage bucket to be created and used for log entries matching the filter."
  type        = string
}

variable "versioning" {
  description = "Toggles bucket versioning, ability to retain a non-current object version when the live object version gets replaced or deleted."
  type        = bool
  default     = true
}

variable "log_sink_writer_identity" {
  description = "The service account that logging uses to write log entries to the destination. (This is available as an output coming from the root module)."
  type        = string
}