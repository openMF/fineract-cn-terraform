provider "aws" {
    region  = "${var.region}"
}

terraform {
    backend "s3" {
        bucket = "fineract-poc-tfstate"
        key = "terraform.tfstate"
        region = "eu-central-1"
        encrypt = true
        dynamodb_table = "fineract-poc-tfstate-lock"
    }
}

module "network" {
    source = "../../modules/network"
    project = "${var.project}"
    environment = "${var.environment}"
    vpc_cidr_block = "${var.vpc_cidr_block}"
}

resource "aws_key_pair" "keypair" {
  key_name = "${var.project}-${var.environment}-ssh-key"
  public_key = "${file(var.public_key_path)}"
}


module "bastion" {
    source = "../../modules/bastion"
    project = "${var.project}"
    environment = "${var.environment}"
    vpc_id = "${module.network.vpc_id}"
    subnet_id = "${module.network.public_subnet_ids[0]}"
    bastion_instance_type = "${var.bastion_instance_type}"
}

module "nginx" {
    source = "../../modules/nginx"
    project = "${var.project}"
    environment = "${var.environment}"
    vpc_id = "${module.network.vpc_id}"
    subnet_ids = "${module.network.public_subnet_ids}"
    bastion_security_group_id = "${module.bastion.bastion_security_group_id}"
    nginx_instance_type = "${var.nginx_instance_type}"
    nginx_instance_count = "${var.nginx_instance_count}"
}

module "infra" {
    source = "../../modules/infra"
    project = "${var.project}"
    environment = "${var.environment}"
    vpc_id = "${module.network.vpc_id}"
    subnet_id = "${module.network.private_subnet_ids[0]}"
    bastion_security_group_id = "${module.bastion.bastion_security_group_id}"
    provisioner_security_group_id = "${module.provisioner.provisioner_security_group_id}"
    nginx_security_group_id = "${module.nginx.nginx_security_group_id}"
    infra_instance_type = "${var.infra_instance_type}"
}

module "mariadb" {
    source = "../../modules/mariadb"
    project = "${var.project}"
    environment = "${var.environment}"
    vpc_id = "${module.network.vpc_id}"
    subnet_ids = "${module.network.private_subnet_ids}"
    bastion_security_group_id = "${module.bastion.bastion_security_group_id}"
    provisioner_security_group_id = "${module.provisioner.provisioner_security_group_id}"
    infra_security_group_id = "${module.infra.infra_security_group_id}"
    mariadb_instance_type = "${var.mariadb_instance_type}"
    mariadb_size = "${var.mariadb_size}"
    mariadb_admin_user = "${var.mariadb_admin_user}"
    mariadb_admin_password = "${var.mariadb_admin_password}"
}

module "provisioner" {
    source = "../../modules/provisioner"
    project = "${var.project}"
    environment = "${var.environment}"
    vpc_id = "${module.network.vpc_id}"
    subnet_id = "${module.network.private_subnet_ids[0]}"
    bastion_security_group_id = "${module.bastion.bastion_security_group_id}"
    provisioner_instance_type = "${var.provisioner_instance_type}"
}
