resource "aws_lb" "default" {
  name            = "${var.name}-main"
  subnets         = var.subnets_id[0]
  security_groups = [aws_security_group.default.id]
}

resource "aws_security_group" "default" {
  name        = "${var.name}-security-group"
  description = "security group for alb load balancer"

  vpc_id = var.vpc_id

  ingress {

    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }

  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
  }

  tags = {
    Name = "${var.name}-security-group"
  }

}

resource "aws_lb_target_group" "default" {
  name        = "${var.name}-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 10
    port                = var.health_check_port
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    interval            = 30
  }
  tags = {
    Name = "${var.name}-target-group"
  }
}

resource "aws_lb_listener" "default" {
  load_balancer_arn = aws_lb.default.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.default.id
    type             = "forward"
  }
  tags = {
    Name = "${var.name}-listener"
  }
}


