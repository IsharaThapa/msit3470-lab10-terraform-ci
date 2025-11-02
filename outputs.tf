output "vpc_id" {
  description = "VPC id"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Public subnet id"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "Security Group id for web"
  value       = aws_security_group.web.id
}

output "instance_id" {
  description = "EC2 instance id"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "Public IP of the instance"
  value       = aws_instance.web.public_ip
}
