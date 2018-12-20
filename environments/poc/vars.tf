variable "region" {
    description = "The AWS region to be used, e.g. eu-central-1."
}

variable "project" {
    description = "The name of the project, e.g. superproject. Can be used for billing purposes."
}

variable "environment" {
    description = "Name of the environment, e.g. dev."
}

variable "vpc_cidr_block" {
    description = "The CIDR block to use for the VPC, e.g. 10.1.0.0/16."
}

variable "public_key_path" {
    description = "Path to the public key that will be installed on all EC2 instances."
}

variable "bastion_instance_type" {
    description = "The EC2 instance type to be used for bastion, e.g. t2.nano."
}

variable "nginx_instance_type" {
    description = "The EC2 instance type to be used for nginx, e.g. t2.micro."
}

variable "nginx_instance_count" {
    description = "Number of nginx instances to launch, e.g. 2."
}

variable "infra_instance_type" {
    description = "The EC2 instance type to be used for the infra instance (running Cassandra, Kafka, ZooKeeper, Eureka), e.g. t2.large."
}

variable "mariadb_instance_type" {
    description = "The instance type to be used for MariaDB, e.g. db.t2.micro."
}

variable "mariadb_size" {
    description = "Space to allocate for the MariaDB database, e.g. 20 (in gigabytes, minimum 20)."
}

variable "mariadb_admin_user" {
    description = "Default admin user for the MariaDB installation."
}

variable "mariadb_admin_password" {
    description = "Default admin password for the MariaDB installation."
}

variable "provisioner_instance_type" {
    description = "The EC2 instance type to be used for the provisioner instance."
}


variable "activemq_admin_user" {
    description = "Default admin user for the ActiveMQ installation."
}

variable "activemq_admin_password" {
    description = "Default admin password fot the ActiveMQ installation"
}


