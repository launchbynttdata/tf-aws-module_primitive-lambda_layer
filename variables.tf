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

variable "name" {
  description = "(Required) Name Lambda Layer"
  type        = string
}

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

variable "source_path" {
  description = "(Required) The absolute path to a local file or directory containing your Lambda source code"
  type        = string
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
