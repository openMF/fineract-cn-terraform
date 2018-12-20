resource "aws_security_group" "nginx_security_group" {
    name = "${var.project}-${var.environment}-nginx-security-group"
    description = "Allows access on HTTP and HTTPS."
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
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
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
            "Name", "${var.project}-${var.environment} nginx security group",
        )
    )}"
}

resource "aws_security_group" "elb_security_group" {
    name = "${var.project}-${var.environment}-elb-security-group"
    description = "Allows access on HTTP and HTTPS."
    vpc_id = "${var.vpc_id}"

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
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
            "Name", "${var.project}-${var.environment} elb security group",
        )
    )}"
}
