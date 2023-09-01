resource "aws_internet_gateway" "myGw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "vpc_igw"
  }
}