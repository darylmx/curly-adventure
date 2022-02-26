resource "aws_db_instance" "main" {
  allocated_storage = var.allocated_storage
  engine            = "mariadb"
  engine_version    = "10.5.13"
  instance_class    = var.instance_class
  identifier_prefix = "${var.name}-instance"

  name     = var.db_name
  username = var.db_user
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.main.id]

  storage_type            = "gp2"
  backup_retention_period = 30   # how long to keep your backups
  skip_final_snapshot     = true # skip final snapshot when doing destroy

  multi_az = "true"

  tags = {
    Name = "${var.name}-main"
  }
}

resource "aws_db_subnet_group" "main" {
  name        = "${var.name}-subnetgroup"
  description = "db subnet group"
  subnet_ids  = var.db_subnets_id[0]
  tags = {
    Name = "${var.name}-subnetgroup"
  }
}


resource "aws_security_group" "main" {
  vpc_id      = var.vpc_id
  name        = "${var.name}-security-group"
  description = "allow-mariadb"
  ingress {
    from_port   = local.mysql_port
    to_port     = local.mysql_port
    protocol    = local.tcp_protocol
    cidr_blocks = var.web_subnets_cidr
  }
  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = [local.all_ips[0]]
    self        = true
  }
  tags = {
    Name = "${var.name}-security-group"
  }
}




