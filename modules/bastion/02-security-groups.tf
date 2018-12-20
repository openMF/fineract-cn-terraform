resource "aws_security_group" "bastion_security_group" {
    name = "${var.project}-${var.environment}-bastion-security-group"
    description = "Allows access on SSH from anywhere."
    vpc_id = "${var.vpc_id}"

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
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
    
    lifecycle {
        create_before_destroy = true
    }
    
    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} bastion security group",
        )
    )}"
}
