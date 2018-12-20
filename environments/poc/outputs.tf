output "vpc_id" {
    value = "${module.network.vpc_id}"
}

output "public_subnet_ids" {
    value = "${module.network.public_subnet_ids}"
}

output "private_subnet_ids" {
    value = "${module.network.private_subnet_ids}"
}

output "bastion_public_ip" {
    value = "${module.bastion.bastion_public_ip}"
}

output "bastion_private_ip" {
    value = "${module.bastion.bastion_private_ip}"
}

output "bastion_security_group_id" {
    value = "${module.bastion.bastion_security_group_id}"
}

output "nginx_elb_dns_name" {
    value = "${module.nginx.nginx_elb_dns_name}"
}

output "nginx_private_ips" {
    value = "${module.nginx.nginx_private_ips}"
}

output "infra_private_ip" {
    value = "${module.infra.infra_private_ip}"
}

output "cassandra_listening_address" {
    value = "${module.infra.cassandra_listening_address}"
}

output "kafka_listening_address" {
    value = "${module.infra.kafka_listening_address}"
}

output "eureka_listening_url" {
    value = "${module.infra.eureka_listening_url}"
}

output "mariadb_endpoint" {
    value = "${module.mariadb.mariadb_endpoint}"
}

output "provisioner_private_ip" {
    value = "${module.provisioner.provisioner_private_ip}"
}

output "provisioner_security_group_id" {
    value = "${module.provisioner.provisioner_security_group_id}"
}

/*
output "activemq_ip" {
    value = "${module.activemq.activemq_ip}"
}

output "activemq_console_url" {
    value = "${module.activemq.activemq_console_url}"
}

output "activemq_endpoints" {
    value = "${module.activemq.activemq_endpoints}"
}
*/