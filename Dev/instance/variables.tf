
variable "region" {
  type        = string
  description = "the default region"
  default     = "europe-west2"

}

variable "project_id" {
  description = "Host project Id"
  type        = string
}

variable "service_account" {
  default = null
  type = object({
    email  = string,
    scopes = set(string)
  })
  description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account."
}

variable "num_instances" {
  description = "Number of instances to create"
  default     = 1
}


variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = ["allow-ssh-ingress", "allow-https-ingress"]
}

variable "labels" {
  type        = map(string)
  description = "Labels, provided as a map"
  default     = {}
}


variable "zone" {
  description = "The GCP zone to create resources in"
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "The subnetwork selflink to host the compute instances in"
}

variable "secret_1" {
  type      = string
  sensitive = true
}
variable "secret_2" {
  type      = string
  sensitive = true

}