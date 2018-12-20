locals {
  common_tags = "${map(
    "project", "${var.project}",
    "environment", "${var.environment}"
  )}"
}
