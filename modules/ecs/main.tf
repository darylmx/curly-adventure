resource "aws_cloudwatch_log_group" "default" {
  name              = var.name
  retention_in_days = 1

  tags = {
    Name = "${var.name}"
  }
}

data "template_file" "myapp-task-definition-template" {
  template = file(var.template_file_path)
  vars     = var.template_file_data
}

resource "aws_ecs_task_definition" "default" {
  family                   = var.app_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory

  task_role_arn         = aws_iam_role.ecs_task_role.arn
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = data.template_file.myapp-task-definition-template.rendered
}

resource "aws_security_group" "default-task" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id

  ingress {
    protocol        = local.tcp_protocol
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [var.load_balancer_security_group_id]
  }

  egress {
    protocol    = local.any_protocol
    from_port   = local.any_port
    to_port     = local.any_port
    cidr_blocks = local.all_ips
  }
}

resource "aws_ecs_cluster" "default" {
  name = "${var.name}-cluster"
}

resource "aws_ecs_service" "default-service" {
  name            = "${var.name}-default-service"
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.default.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.default-task.id]
    subnets         = var.subnets_id[0]
  }

  load_balancer {
    target_group_arn = var.load_balancer_target_group_id
    container_name   = var.app_name
    container_port   = var.app_port
  }
}



