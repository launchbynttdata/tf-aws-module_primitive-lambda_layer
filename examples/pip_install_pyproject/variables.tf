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

variable "description" {
  description = "(Optional) Description of the Lambda Layer"
  type        = string
  default     = ""
}

variable "compatible_runtimes" {
  description = "(Required) A list of Runtimes this layer is compatible with. Specify a maximum of 5 runtimes."
  type        = list(string)
}

variable "compatible_architectures" {
  description = "(Optional) Architectures that this layer is compatible with. Currently only x86_64 and arm64 are supported."
  type        = list(string)
  default     = []
}

variable "store_on_s3" {
  description = "(Optional) Whether to store produced artifacts on S3 or locally. Defaults to false (local)."
  type        = bool
  default     = false
}

variable "s3_bucket" {
  description = "S3 bucket to store artifacts. Required only when store_on_s3 is set to true."
  type        = string
  default     = null
}

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
    region     = optional(string, "us-east-2")
  }))

  default = {
    layer = {
      name       = "lyr"
      max_length = 80
    }
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 0 to 999."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "layer"
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  nullable    = false
  default     = "demo"

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "pyproject_path" {
  description = "Path to the pyproject.toml file to be turned into a Lambda Layer. You must supply a trailing slash. If you wish to install an optional dependency set (e.g. `dev`), specify this value in the form `relative/path/to/project/[dev]`"
  type        = string

  validation {
    condition     = can(regex("/$|/\\[.+\\]$", var.pyproject_path))
    error_message = "You must supply a trailing slash."
  }
}
