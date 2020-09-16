# Define VPC
resource "aws_vpc" "My_VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "DevOpsTest-VPC"
  }
}

# Define Public Subnet
resource "aws_subnet" "pub_subnet" {
  vpc_id            = aws_vpc.My_VPC.id
  cidr_block        = var.pub_subnet_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "DevOpsTest_Pub_Subnet"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "My_GW" {
  vpc_id = aws_vpc.My_VPC.id

  tags = {
    Name = "DevOps_IGW"
  }
}

# Define the Route table
resource "aws_route_table" "pub_route" {
  vpc_id = aws_vpc.My_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.My_GW.id
  }

  tags = {
    Name = "DevOps_RT"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "pub_route" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.pub_route.id
}

# Define the security group for public subnet
resource "aws_security_group" "es-sec-grp" {
  name        = "vpc_test_elasticsearch"
  description = "Allow incoming Elastic serach node connections & SSH access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.My_VPC.id

  tags = {
    Name = "DevOpsTest-SG"
  }
}