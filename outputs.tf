output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "ID of public subnet 1"
  value       = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "ID of public subnet 2"
  value       = aws_subnet.public_2.id
}

output "web_security_group_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web.id
}

output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "web_server_1_id" {
  description = "ID of web server 1"
  value       = aws_instance.web_1.id
}

output "web_server_1_public_ip" {
  description = "Public IP of web server 1"
  value       = aws_instance.web_1.public_ip
}

output "web_server_1_public_dns" {
  description = "Public DNS of web server 1"
  value       = aws_instance.web_1.public_dns
}

output "web_server_2_id" {
  description = "ID of web server 2"
  value       = aws_instance.web_2.id
}

output "web_server_2_public_ip" {
  description = "Public IP of web server 2"
  value       = aws_instance.web_2.public_ip
}

output "web_server_2_public_dns" {
  description = "Public DNS of web server 2"
  value       = aws_instance.web_2.public_dns
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "target_group_arn" {
  description = "ARN of the web target group"
  value       = aws_lb_target_group.web.arn
}