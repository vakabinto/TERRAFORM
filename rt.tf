resource "aws_route_table" "publicRt" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block                = "0.0.0.0/0"
      gateway_id                = aws_internet_gateway.myGw.id
  }
}
resource "aws_route_table" "privateRt" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block                = "0.0.0.0/0"
      gateway_id                = aws_nat_gateway.myNat.id
  }
}
resource "aws_route_table_association" "pubRtAss1" {
  subnet_id      = aws_subnet.mysubPub1.id
  route_table_id = aws_route_table.publicRt.id
}

resource "aws_route_table_association" "pubRtAss2" {
  subnet_id      = aws_subnet.mysubPub2.id
  route_table_id = aws_route_table.publicRt.id
}
resource "aws_route_table_association" "privRtAss1" {
  subnet_id      = aws_subnet.mysubPriv1.id
  route_table_id = aws_route_table.privateRt.id
}
resource "aws_route_table_association" "privRtAss2" {
  subnet_id      = aws_subnet.mysubPriv2.id
  route_table_id = aws_route_table.privateRt.id
}