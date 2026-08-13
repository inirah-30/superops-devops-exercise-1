output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_1_id" {
  value = module.networking.public_subnet_1_id
}

output "public_subnet_2_id" {
  value = module.networking.public_subnet_2_id
}

output "alb_security_group_id" {
  value = module.security.alb_security_group_id
}

output "web_security_group_id" {
  value = module.security.web_security_group_id
}

output "web_server_1_id" {
  value = module.web_server_1.instance_id
}

output "web_server_1_public_ip" {
  value = module.web_server_1.public_ip
}

output "web_server_1_public_dns" {
  value = module.web_server_1.public_dns
}

output "web_server_2_id" {
  value = module.web_server_2.instance_id
}

output "web_server_2_public_ip" {
  value = module.web_server_2.public_ip
}

output "web_server_2_public_dns" {
  value = module.web_server_2.public_dns
}

output "alb_dns_name" {
  value = module.load_balancer.alb_dns_name
}

output "target_group_arn" {
  value = module.load_balancer.target_group_arn
}