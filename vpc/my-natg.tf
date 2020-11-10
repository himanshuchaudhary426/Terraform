resource "aws_nat_gateway" "my-ngw" {
  allocation_id = aws_eip.nat-ip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "gw NAT"
  }
}