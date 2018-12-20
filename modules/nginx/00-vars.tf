variable "project" {
    description = "The name of the project, e.g. superproject. Can be used for billing purposes."
}

variable "environment" {
    description = "The environment to be used, e.g. dev."
}

variable "vpc_id" {
    description = "The nginx instances are installed to this VPC."
}

variable "subnet_ids" {
    description = "The nginx instances are installed to these subnets."
    type = "list"
}

variable "bastion_security_group_id" {
  description = "The security group used by the bastion host. Used to allow SSH access from the bastion."
}

variable "nginx_instance_type" {
    description = "The EC2 instance type to be used for nginx, e.g. t2.micro."
}

variable "nginx_instance_count" {
    description = "Number of nginx instances to launch, e.g. 2."
}
