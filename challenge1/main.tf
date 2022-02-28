locals {

  project_name = "challenge1"
  environment  = "test"
  name_prefix  = "${local.project_name}-${local.environment}"

  amis = {
    ap-southeast-1 = "ami-01079af93e791f059" ### ubuntu
  }

  availability_zones = ["${local.aws_region}a", "${local.aws_region}b"]
  aws_region         = "ap-southeast-1"
  app_http_port      = 8080

}

module "network" {
  source = "../modules/network"

  name = "${local.name_prefix}-network"

  region               = local.aws_region
  availability_zones   = local.availability_zones
  vpc_cidr             = "11.0.0.0/16"
  public_subnets_cidr  = ["11.0.1.0/24", "11.0.2.0/24"]
  private_subnets_cidr = ["11.0.4.0/24", "11.0.5.0/24"]
  db_subnets_cidr      = ["11.0.14.0/24", "11.0.15.0/24"]
}

module "asg" {
  source = "../modules/asg"

  name = "${local.name_prefix}-asg"

  vpc_id              = module.network.vpc_id
  vpc_zone_identifier = module.network.private_subnets_id

  image_id           = local.amis[local.aws_region]
  instance_type      = "t3.nano"
  load_balancer_name = module.lb.name
  security_group_id  = module.instance.security_group_id
  min_elb_capacity   = 1
  min_size           = 2
  max_size           = 4

  # Webapp customization settings
  template_file_path = "${path.module}/templates/init_webapp.tpl"
  template_file_data = {
    ELB_HOSTNAME = module.lb.dns_name
    DB_HOSTNAME  = module.db.db_address
    DB_NAME      = var.db_name
    DB_PASSWORD  = var.db_password
    DB_USERNAME  = var.db_username
  }
}

module "lb" {
  source = "../modules/elb"

  name = "${local.name_prefix}-lb"

  vpc_id                 = module.network.vpc_id
  subnets_id             = module.network.public_subnets_id
  listener_instance_port = local.app_http_port
  health_check_target    = "HTTP:${local.app_http_port}/"
}

module "instance" {
  source = "../modules/instance"

  name = "${local.name_prefix}-webapp"

  vpc_id                          = module.network.vpc_id
  app_port_range_min              = local.app_http_port
  app_port_range_max              = local.app_http_port
  load_balancer_security_group_id = module.lb.security_group_id
}

module "db" {
  source = "../modules/mariadb"

  name = "${local.name_prefix}-db"

  vpc_id           = module.network.vpc_id
  db_subnets_id    = module.network.db_subnets_id
  web_subnets_cidr = ["11.0.4.0/24", "11.0.5.0/24"]

  allocated_storage = 10
  instance_class    = "db.t3.micro"

  db_name     = var.db_name
  db_user     = var.db_username
  db_password = var.db_password
}
