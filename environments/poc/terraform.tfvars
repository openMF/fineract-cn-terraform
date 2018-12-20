region = "eu-central-1"
environment = "poc"
project = "fineract"

vpc_cidr_block = "10.1.0.0/16"

public_key_path = "./id_rsa.pub"

bastion_instance_type = "t2.nano"

nginx_instance_type = "t2.micro"
nginx_instance_count = 1

infra_instance_type = "t2.large"

mariadb_instance_type = "db.t2.micro"
mariadb_size = 20
mariadb_admin_user = "admin"
mariadb_admin_password = "adminadminadmin"

provisioner_instance_type = "t2.large"

activemq_admin_user = "admin"
activemq_admin_password = "adminadminadmin" // minimum 12 characters, minimum 4 different characters
