variable "project" {
    description = "The name of the project, e.g. superproject. Can be used for billing purposes."
}

variable "environment" {
    description = "The environment to be used, e.g. dev."
}

variable "vpc_id" {
    description = "The bastion instance is installed to this VPC."
}

variable "bastion_security_group_id" {
  description = "The security group used by the bastion host. Used to allow SSH access from the bastion."
}

variable "provisioner_security_group_id" {
  description = "The security group used by the provisioner host."
}

variable "infra_security_group_id" {
    description = "The security group used by the infra host."
}

variable "subnet_ids" {
    description = "The nginx instances are installed to these subnets."
    type = "list"
}

variable "mariadb_instance_type" {
    description = "The instance type to be used for MariaDB, e.g. db.t2.micro."
}

variable "mariadb_size" {
    description = "The space to allocate for the MariaDB installation. Minimum is 20 GB."
    default = 20
}

variable "mariadb_admin_user" {
    description = "Default admin user for the MariaDB installation."
}

variable "mariadb_admin_password" {
    description = "Default admin password fot the MariaDB installation"
}
