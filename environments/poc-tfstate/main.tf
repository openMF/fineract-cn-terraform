provider "aws" {
    region  = "${var.region}"
}

module "tfstate-s3" {
    source = "../../modules/tfstate-s3"
    project = "${var.project}"
    environment = "${var.environment}"
}