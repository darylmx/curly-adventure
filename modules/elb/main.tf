resource "aws_elb" "main" {
  name = "${var.name}-main"

  subnets         = var.subnets_id[0]
  security_groups = [aws_security_group.main.id]

  listener {
    instance_port     = var.listener_instance_port
    instance_protocol = local.http_protocol
    lb_port           = local.http_port
    lb_protocol       = local.http_protocol
  }

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = 3
    target              = var.health_check_target
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "${var.name}-main"
  }
}

resource "aws_security_group" "main" {

  name        = "${var.name}-security-group"
  description = "security group for load balancer"

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
