resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "terra-vpc"
  }
}
resource "aws_subnet" "mysub-pub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "mysub-pub1"
  }
}
resource "aws_subnet" "mysub-pub2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "mysub-pub2"
  }
}
resource "aws_subnet" "mysub-priv1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "mysub-priv1"
  }
}
resource "aws_subnet" "mysub-priv2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "mysub-priv2"
  }
}
resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "mygw"
  }
}
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }
}
resource "aws_route_table_association" "rt-assoc-1" {
  subnet_id      = aws_subnet.mysub-pub1.id
  route_table_id = aws_route_table.myrt.id
}
resource "aws_route_table_association" "rt-assoc-2" {
  subnet_id      = aws_subnet.mysub-pub2.id
  route_table_id = aws_route_table.myrt.id
}