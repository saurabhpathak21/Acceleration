<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 5.0, >= 2.12 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | < 5.0, >= 3.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute_instance"></a> [compute\_instance](#module\_compute\_instance) | ../../modules/compute | n/a |
| <a name="module_instance_template"></a> [instance\_template](#module\_instance\_template) | ../../modules/template | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.instance](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_labels"></a> [labels](#input\_labels) | Labels, provided as a map | `map(string)` | `{}` | no |
| <a name="input_num_instances"></a> [num\_instances](#input\_num\_instances) | Number of instances to create | `number` | `1` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Host project Id | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | the default region | `string` | `"europe-west2"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account. | <pre>object({<br>    email  = string,<br>    scopes = set(string)<br>  })</pre> | `null` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnetwork selflink to host the compute instances in | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Network tags, provided as a list | `list(string)` | <pre>[<br>  "allow-ssh-ingress",<br>  "allow-https-ingress"<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The GCP zone to create resources in | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->