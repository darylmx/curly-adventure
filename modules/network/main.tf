resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_eip" "nat_eip" {

  count = length(var.private_subnets_cidr)

  vpc        = true
  depends_on = [aws_internet_gateway.ig]
  tags = {
    Name = "${var.name}-nat_eip"
  }
}

resource "aws_nat_gateway" "nat" {

  count = length(var.private_subnets_cidr)

  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Name = "${var.name}-${element(var.availability_zones, count.index)}-natgw"
  }
}

#--- subnets
resource "aws_subnet" "public_subnet" {

  count = length(var.public_subnets_cidr)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-${element(var.availability_zones, count.index)}-public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {

  count = length(var.private_subnets_cidr)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.name}-${element(var.availability_zones, count.index)}-private_subnet"
  }
}

resource "aws_subnet" "db_subnet" {

  count = try(length(var.db_subnets_cidr), 0)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.db_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.name}-${element(var.availability_zones, count.index)}-db_subnet"
  }
}

#--- Routing table for subnets
resource "aws_route_table" "private" {

  count = length(var.private_subnets_cidr)

  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-${element(var.availability_zones, count.index)}-private_route_table"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-public_route_table"
  }
}

#--- Routing for gateways
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = local.all_ips[0]
  gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route" "private_nat_gateway" {

  count = length(var.private_subnets_cidr)

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = local.all_ips[0]
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
}

#--- Route table associations
resource "aws_route_table_association" "public" {

  count = length(var.public_subnets_cidr)

  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {

  count = length(var.private_subnets_cidr)

  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
