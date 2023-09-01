resource "aws_vpc" "main" {
  cidr_block = "172.30.0.0/16"
  tags = {
    Name = "EKS-VPC"
  }
}