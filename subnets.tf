resource "aws_subnet" "mysubPriv1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.30.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name                              = "eksPriv1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}
resource "aws_subnet" "mysubPub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.30.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"


  tags = {
    Name                         = "eks-pub1"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"

  }
}
resource "aws_subnet" "mysubPriv2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.30.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "false"


  tags = {
    Name                              = "eks-priv2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"

  }
}
resource "aws_subnet" "mysubPub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.30.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"


  tags = {
    Name                         = "eks-pub2"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"

  }
}