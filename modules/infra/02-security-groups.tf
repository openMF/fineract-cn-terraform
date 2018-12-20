resource "aws_security_group" "infra_security_group" {
    name = "${var.project}-${var.environment}-infra-security-group"
    description = "Allows access on SSH from the bastion + listening on Cassandra port + listening on Kafka port + listening on Eureka port."
    vpc_id = "${var.vpc_id}"

    ingress {
        description = "Allow SSH from bastion"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [
            "${var.bastion_security_group_id}"
        ]
    }

    ingress {
        description = "Allow Cassandra (CQL native transport port) from provisioner"
        from_port = 9042
        to_port = 9042
        protocol = "tcp"
        security_groups = [
            "${var.provisioner_security_group_id}"
        ]
    }

    ingress {
        description = "Allow Zookeeper from provisioner"
        from_port = 9092
        to_port = 9092
        protocol = "tcp"
        security_groups = [
            "${var.provisioner_security_group_id}"
        ]
    }

    // Microservice port (for nginx, bastion)
    ingress {
        description = "Allow Identity Service for Nginx and bastion"
        from_port = 2021
        to_port = 2021
        protocol = "tcp"
        security_groups = [
            "${var.nginx_security_group_id}",
            "${var.bastion_security_group_id}"
        ]
    }

    ingress {
        description = "Allow Office Service for Nginx and bastion"
        from_port = 2023
        to_port = 2023
        protocol = "tcp"
        security_groups = [
            "${var.nginx_security_group_id}",
            "${var.bastion_security_group_id}"
        ]
    }

    ingress {
        description = "Allow Customer Customer for Nginx and bastion"
        from_port = 2024
        to_port = 2024
        protocol = "tcp"
        security_groups = [
            "${var.nginx_security_group_id}",
            "${var.bastion_security_group_id}"
        ]
    }

    ingress {
        description = "Allow Customer Accounting for Nginx and bastion"
        from_port = 2025
        to_port = 2025
        protocol = "tcp"
        security_groups = [
            "${var.nginx_security_group_id}",
            "${var.bastion_security_group_id}"
        ]
    }

    ingress {
        description = "Allow Deposit Accounting for Nginx and bastion"
        from_port = 2027
        to_port = 2027
        protocol = "tcp"
        security_groups = [
            "${var.nginx_security_group_id}",
            "${var.bastion_security_group_id}"
        ]
    }

    egress {
        description = "anything"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    lifecycle {
        create_before_destroy = true
    }
    
    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} infra security group",
        )
    )}"
}
