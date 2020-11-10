

resource "aws_instance" "public-instance" {
  ami           = "ami-0cda377a1b884a1bc"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet.id
  security_groups = [aws_security_group.public_instance.id]
  key_name = "ebs"
  user_data = file("script.sh")

  tags = {
    Name = "public-instance"
  }
}


resource "aws_instance" "private-instance" {
  ami           =  "ami-0cda377a1b884a1bc"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private-subnet.id
  security_groups = [aws_security_group.private_instance.id]
  key_name = "aws"

  tags = {
    Name = "private-instance"
  }
}
