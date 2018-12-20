variable "project" {
    description = "The name of the project, e.g. superproject. Can be used for billing purposes."
}

variable "environment" {
    description = "Name of the environment, e.g. dev."

}
variable "vpc_cidr_block" {
    description = "The CIDR block to be used for the VPC, e.g. 10.0.0.0/16."
}
