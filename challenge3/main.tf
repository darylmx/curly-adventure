locals {

  project_name = "challenge3"
  environment  = "test"
  name_prefix  = "${local.project_name}-${local.environment}"

  availability_zones = ["${local.aws_region}a", "${local.aws_region}b"]
  aws_region         = "ap-southeast-1"

  app_name     = "default-app"
  app_port     = 8080
  app_protocol = "http"
}

module "network" {
  source = "../modules/network"

  name = "${local.name_prefix}-network"

  region               = local.aws_region
  vpc_cidr             = "14.0.0.0/16"
  public_subnets_cidr  = ["14.0.1.0/24", "14.0.2.0/24"]
  private_subnets_cidr = ["14.0.4.0/24", "14.0.5.0/24"]
  availability_zones   = local.availability_zones
}

module "lb" {
  source = "../modules/elb_v2"

  name   = "${local.name_prefix}-alb"
  vpc_id = module.network.vpc_id

  subnets_id        = module.network.public_subnets_id
  health_check_port = local.app_port
  health_check_path = "/api/ping"
}

module "ecs" {
  source = "../modules/ecs"

  name = "${local.name_prefix}-ecs"

  vpc_id                 = module.network.vpc_id
  subnets_id             = module.network.private_subnets_id
  app_count              = 2
  app_name               = local.app_name
  app_port               = local.app_port
  task_definition_cpu    = 1024
  task_definition_memory = 2048

  load_balancer_security_group_id = module.lb.security_group_id
  load_balancer_target_group_id   = module.lb.target_group_id

  template_file_path = "${path.module}/templates/ecs-app.json.tpl"
  template_file_data = {
    REPOSITORY_URL   = "${module.ecr.repo_url}"
    TAG              = "1"
    CONTAINER_CPU    = 1024
    CONTAINER_MEMORY = 2048
    APP_NAME         = "${local.app_name}"
    APP_PORT         = "${local.app_port}"
    LOG_GROUP        = "${local.name_prefix}-ecs"
    LOG_REGION       = "${local.aws_region}"
  }
}

module "ecr" {
  source = "../modules/ecr"

  name = "${local.name_prefix}-ecr/${local.app_name}"
}
