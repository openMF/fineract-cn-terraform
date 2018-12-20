resource "aws_instance" "bastion" {
    instance_type        = "${var.bastion_instance_type}"
    ami                  = "${data.aws_ami.bastion-ami.id}"
    subnet_id            = "${var.subnet_id}"
    iam_instance_profile = "${aws_iam_instance_profile.bastion_iam_instance_profile.id}"
    key_name             = "${var.project}-${var.environment}-ssh-key"
    
    vpc_security_group_ids = [
        "${aws_security_group.bastion_security_group.id}"
    ]

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} bastion instance"
        )
    )}"


}

resource "aws_eip" "bastion-eip" {
    instance = "${aws_instance.bastion.id}"
    vpc      = true
    
    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} bastion EIP"
        )
    )}"
}
