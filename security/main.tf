terraform {
  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.env}-${var.ec2_role_name}"

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
}

resource "aws_iam_role_policy" "devops_policy" {
  name = "ec2-s3-policy"
  role = "${aws_iam_role.ec2_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.env}-ec2_instance_profile"
  role = "${aws_iam_role.ec2_role.name}"
}
