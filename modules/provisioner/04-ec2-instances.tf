resource "aws_instance" "provisioner" {
    instance_type        = "${var.provisioner_instance_type}"
    ami                  = "${data.aws_ami.provisioner-ami.id}"
    subnet_id            = "${var.subnet_id}"
    key_name             = "${var.project}-${var.environment}-ssh-key"
    
    vpc_security_group_ids = [
        "${aws_security_group.provisioner_security_group.id}"
    ]

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} provisioner instance"
        )
    )}"


}
