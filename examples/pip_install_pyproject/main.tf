// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "layer" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/lambda_layer/aws"
  version = "~> 1.0"

  name                     = module.resource_names["layer"].minimal_random_suffix
  description              = var.description
  compatible_runtimes      = var.compatible_runtimes
  compatible_architectures = var.compatible_architectures

  source_path = "lambda_layer.zip"

  store_on_s3 = var.store_on_s3
  s3_bucket   = var.s3_bucket

  depends_on = [data.archive_file.layer_zip]
}

module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 1.0"

  for_each = var.resource_names_map

  region                  = join("", split("-", each.value.region))
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}

resource "terraform_data" "pyproject_toml_md5sum" {
  input = filemd5("${replace(var.pyproject_path, "/\\[.+\\]/", "")}/pyproject.toml")
}

resource "terraform_data" "pyproject_path" {
  input = var.pyproject_path
}

resource "null_resource" "layer_folder_generation" {
  lifecycle {
    replace_triggered_by = [terraform_data.pyproject_toml_md5sum, terraform_data.pyproject_path]
  }
  provisioner "local-exec" {
    command = "./layer_folder_from_pyproject.sh ${var.pyproject_path} ./lambda_layer"
  }
}

data "archive_file" "layer_zip" {
  type        = "zip"
  source_dir  = "./lambda_layer"
  output_path = "lambda_layer.zip"

  depends_on = [null_resource.layer_folder_generation]
}
