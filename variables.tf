variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR for public subnet 1"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR for public subnet 2"
  type        = string
}

variable "availability_zone_1" {
  description = "Availability zone for web server 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability zone for web server 2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed for SSH"
  type        = string
}