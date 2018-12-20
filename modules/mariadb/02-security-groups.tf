resource "aws_security_group" "mariadb_security_group" {
    name = "${var.project}-${var.environment}-mariadb-security-group"
    description = "Allows access on the MariaDB access port."
    vpc_id = "${var.vpc_id}"

    // TODO: add other needed security groups here (when they begin to exist)
    ingress {
        description = "MariaDB access port"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [
            "${var.bastion_security_group_id}",
            "${var.provisioner_security_group_id}",
            "${var.infra_security_group_id}"
        ]
    }
    
    egress {
        description = "anything"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} mariadb security group",
        )
    )}"
}
