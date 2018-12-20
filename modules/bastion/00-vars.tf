variable "project" {
    description = "The name of the project, e.g. superproject. Can be used for billing purposes."
}

variable "environment" {
    description = "The environment to be used, e.g. dev."
}

variable "vpc_id" {
    description = "The bastion instance is installed to this VPC."
}

variable "subnet_id" {
    description = "The bastion instance is installed to this subnet."
}

variable "bastion_instance_type" {
    description = "The EC2 instance type to be used for bastion, e.g. t2.nano."
}
