#VPC CREATION
resource "aws_vpc" "Myvpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

#INTERNET GATEWAY FOR PUBLIC
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.Myvpc.id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

#CREATING ELASTIC IP (EIP) FOR NAT
resource "aws_eip" "nat_eip" {
  #vpc        = true
  depends_on = [aws_internet_gateway.ig]
}
# CREATING  NAT GATEWAY

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)

  tags = {
    Name        = "nat"
    Environment = "${var.environment}"
  }
}

#CREATION OF PUBLIC SUBNET
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.Myvpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
    Environment = "${var.environment}"


  }
}
#CREATION OF PRIVATE SUBNET
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.Myvpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              =  element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
   Name        = "${var.environment}-${element(var.availability_zones, count.index)}-private-subnet"
    Environment = "${var.environment}"


  }
}

# CREATION OF ROUTE TABLE FOR PUBLIC SUBNET
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.Myvpc.id

  tags = {
    Name        = "${var.environment}-public-route-table"
    Environment = "${var.environment}"
  }
}

# CREATION OF ROUTE TABLE FOR PRIVATE SUBNET
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.Myvpc.id

  tags = {
    Name        = "${var.environment}-private-route-table"
    Environment = "${var.environment}"
  }
}

#ROUTING FOR INTERNET GATEWAY
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

#ROUTING FOR NAT GATEWAY
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

#ROUTE TABLE ASSOCIATIN FOR PUBLIC SUBNET
resource "aws_route_table_association" "public" {
   count          = length(var.public_subnets_cidr)
   subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
#ROUTE TABLE ASSOCIATIN FOR PRIVATE SUBNET
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

# Default Security Group of VPC
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default SG to alllow traffic from the VPC"
  vpc_id      = aws_vpc.Myvpc.id
  depends_on = [
    aws_vpc.Myvpc
  ]

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "${var.environment}"
  }
}

