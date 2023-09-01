resource "aws_eip" "eip" {
  domain = "vpc"
  tags = {
    Name = "eip"
  }
}

resource "aws_nat_gateway" "myNat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.mysubPub1.id

  tags = {
    Name = "my-NAT"
  }

  depends_on = [aws_internet_gateway.myGw]
}