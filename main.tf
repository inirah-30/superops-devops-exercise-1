module "networking" {
  source = "./modules/networking"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  availability_zone_1  = var.availability_zone_1
  availability_zone_2  = var.availability_zone_2
}

module "security" {
  source = "./modules/security"

  project_name      = var.project_name
  vpc_id            = module.networking.vpc_id
  ssh_allowed_cidr  = var.ssh_allowed_cidr
}

module "web_server_1" {
  source = "./modules/ec2"

  project_name      = var.project_name
  instance_name     = "${var.project_name}-web-1"
  subnet_id         = module.networking.public_subnet_1_id
  security_group_id = module.security.web_security_group_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  server_label = "Server1"
}

module "web_server_2" {
  source = "./modules/ec2"

  project_name      = var.project_name
  instance_name     = "${var.project_name}-web-2"
  subnet_id         = module.networking.public_subnet_2_id
  security_group_id = module.security.web_security_group_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  server_label = "Server2"
}

module "load_balancer" {
  source = "./modules/load_balancer"

  project_name           = var.project_name
  vpc_id                 = module.networking.vpc_id
  subnet_1_id            = module.networking.public_subnet_1_id
  subnet_2_id            = module.networking.public_subnet_2_id
  alb_security_group_id  = module.security.alb_security_group_id
  web_server_1_id        = module.web_server_1.instance_id
  web_server_2_id        = module.web_server_2.instance_id
}