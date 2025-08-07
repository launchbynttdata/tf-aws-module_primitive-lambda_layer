# already_zipped

Example for creating a Lambda layer from a preexisting zip file.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_layer"></a> [layer](#module\_layer) | ../.. | n/a |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | (Optional) Description of the Lambda Layer | `string` | `""` | no |
| <a name="input_compatible_runtimes"></a> [compatible\_runtimes](#input\_compatible\_runtimes) | (Required) A list of Runtimes this layer is compatible with. Specify a maximum of 5 runtimes. | `list(string)` | n/a | yes |
| <a name="input_compatible_architectures"></a> [compatible\_architectures](#input\_compatible\_architectures) | (Optional) Architectures that this layer is compatible with. Currently only x86\_64 and arm64 are supported. | `list(string)` | `[]` | no |
| <a name="input_source_path"></a> [source\_path](#input\_source\_path) | (Required) The absolute path to a local file or directory containing your Lambda source code | `string` | n/a | yes |
| <a name="input_store_on_s3"></a> [store\_on\_s3](#input\_store\_on\_s3) | (Optional) Whether to store produced artifacts on S3 or locally. Defaults to false (local). | `bool` | `false` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 bucket to store artifacts. Required only when store\_on\_s3 is set to true. | `string` | `null` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br/>    name       = string<br/>    max_length = optional(number, 60)<br/>    region     = optional(string, "us-east-2")<br/>  }))</pre> | <pre>{<br/>  "layer": {<br/>    "max_length": 80,<br/>    "name": "lyr"<br/>  }<br/>}</pre> | no |
| <a name="input_resource_names_strategy"></a> [resource\_names\_strategy](#input\_resource\_names\_strategy) | Strategy to use for generating resource names, taken from the outputs of the naming module, e.g. 'standard', 'minimal\_random\_suffix', 'dns\_compliant\_standard', etc. | `string` | `"minimal_random_suffix"` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br/>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br/>    For example, backend, frontend, middleware etc. | `string` | `"example"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example: dev, qa, uat | `string` | `"sandbox"` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to this resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_layer_arn"></a> [lambda\_layer\_arn](#output\_lambda\_layer\_arn) | n/a |
| <a name="output_lambda_layer_version"></a> [lambda\_layer\_version](#output\_lambda\_layer\_version) | n/a |
<!-- END_TF_DOCS -->
