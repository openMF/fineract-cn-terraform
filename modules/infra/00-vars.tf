variable "project" {
    description = "The name of the project, e.g. superproject. Can be used for billing purposes."
}

variable "environment" {
    description = "The environment to be used, e.g. dev."
}

variable "vpc_id" {
    description = "The infra instance is installed to this VPC."
}

variable "subnet_id" {
    description = "The infra instance is installed to this subnet."
}

variable "bastion_security_group_id" {
  description = "The security group used by the bastion host. Used to allow SSH access from the bastion."
}

variable "provisioner_security_group_id" {
  description = "The security group used by the provisioner host."
}

variable "nginx_security_group_id" {
  description = "The security group used by the nginx hosts."
}

variable "infra_instance_type" {
    description = "The EC2 instance type to be used for the infra instance (running Cassandra, Kafka, ZooKeeper, Eureka), e.g. t2.large."
}
