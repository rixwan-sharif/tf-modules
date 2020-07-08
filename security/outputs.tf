output "ec2_instance_profile" {
  value       = aws_iam_instance_profile.ec2_instance_profile.name
  description = "EC2 instance profile name"
}