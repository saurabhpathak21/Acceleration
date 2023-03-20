<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.53, < 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_log_export"></a> [log\_export](#module\_log\_export) | terraform-google-modules/log-export/google | n/a |
| <a name="module_logging_bucket"></a> [logging\_bucket](#module\_logging\_bucket) | ../modules/logging/storage | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location of the log bucket. | `string` | `"europe-west2"` | no |
| <a name="input_log_sink_writer_identity"></a> [log\_sink\_writer\_identity](#input\_log\_sink\_writer\_identity) | The service account that logging uses to write log entries to the destination. (This is available as an output coming from the root module). | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the log bucket will be created. | `string` | n/a | yes |
| <a name="input_storage_bucket_name"></a> [storage\_bucket\_name](#input\_storage\_bucket\_name) | The name of the storage bucket to be created and used for log entries matching the filter. | `string` | n/a | yes |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Toggles bucket versioning, ability to retain a non-current object version when the live object version gets replaced or deleted. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->