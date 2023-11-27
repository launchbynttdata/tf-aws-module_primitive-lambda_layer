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

module "lambda_layer" {
  source = "terraform-aws-modules/lambda/aws"

  create_layer    = true
  create_function = false

  layer_name  = var.name
  description = var.description

  compatible_runtimes      = var.compatible_runtimes
  compatible_architectures = var.compatible_architectures

  source_path = var.source_path != null && var.store_on_s3 == false ? "${var.source_path}" : null

  store_on_s3 = var.store_on_s3
  s3_bucket   = var.s3_bucket
}
