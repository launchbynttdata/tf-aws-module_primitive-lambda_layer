# complete

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_layer"></a> [layer](#module\_layer) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_length"></a> [length](#input\_length) | Length of random string to suffix the layer name | `number` | `12` | no |
| <a name="input_create_layer"></a> [create\_layer](#input\_create\_layer) | Controls whether Lambda Layer resource should be created, default true | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name Lambda Layer | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) Description of the Lambda Layer | `string` | `""` | no |
| <a name="input_compatible_runtimes"></a> [compatible\_runtimes](#input\_compatible\_runtimes) | (Required) A list of Runtimes this layer is compatible with. Specify a maximum of 5 runtimes. | `list(string)` | n/a | yes |
| <a name="input_compatible_architectures"></a> [compatible\_architectures](#input\_compatible\_architectures) | (Optional) Architectures that this layer is compatible with. Currently only x86\_64 and arm64 are supported. | `list(string)` | `[]` | no |
| <a name="input_source_path"></a> [source\_path](#input\_source\_path) | (Required) The absolute path to a local file or directory containing your Lambda source code | `string` | n/a | yes |
| <a name="input_store_on_s3"></a> [store\_on\_s3](#input\_store\_on\_s3) | (Optional) Whether to store produced artifacts on S3 or locally. Defaults to false (local). | `bool` | `false` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 bucket to store artifacts. Required only when store\_on\_s3 is set to true. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_layer_arn"></a> [lambda\_layer\_arn](#output\_lambda\_layer\_arn) | n/a |
| <a name="output_lambda_layer_version"></a> [lambda\_layer\_version](#output\_lambda\_layer\_version) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
