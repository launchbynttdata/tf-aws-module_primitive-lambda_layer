locals {
  randomized_name = "${var.name}-${random_string.suffix.result}"
}
