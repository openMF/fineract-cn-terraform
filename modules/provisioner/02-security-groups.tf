resource "aws_security_group" "provisioner_security_group" {
    name = "${var.project}-${var.environment}-provisioner-security-group"
    description = "Allows access on SSH from the bastion."
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
            "Name", "${var.project}-${var.environment} provisioner security group",
        )
    )}"
}
