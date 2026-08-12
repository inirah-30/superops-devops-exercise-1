variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name used for resource naming and tagging"
  type        = string
  default     = "superops-loadbalancer"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "allowed_cidr" {
  description = "CIDR allowed to access the web servers"
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}