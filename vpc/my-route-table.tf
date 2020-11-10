
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my-ngw.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rta" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}