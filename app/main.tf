terraform {
  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {

  count                = var.instance_count
  ami                  = "ami-0ac80df6eff0e70b5"
  key_name             = "inovalon-devops-kp"
  iam_instance_profile = var.iam_role
  instance_type        = var.instance_type
}


