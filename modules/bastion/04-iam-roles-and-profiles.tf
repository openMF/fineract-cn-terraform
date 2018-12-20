resource "aws_iam_role" "bastion_iam_role" {
    name = "bastion-iam-role"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project} bastion IAM role",
        )
    )}"
}

resource "aws_iam_instance_profile" "bastion_iam_instance_profile" {
    name  = "bastion-iam-instance-profile"
    role = "${aws_iam_role.bastion_iam_role.id}"
}
