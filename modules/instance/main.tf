resource "aws_security_group" "main" {

  name        = "${var.name}-security-group"
  vpc_id      = var.vpc_id
  description = "security group for instance"
  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
  }

  ingress {
    from_port       = var.app_port_range_min
    to_port         = var.app_port_range_max
    protocol        = local.tcp_protocol
    security_groups = [var.load_balancer_security_group_id]
  }

  tags = {
    Name = "${var.name}-security-group"
  }
}
