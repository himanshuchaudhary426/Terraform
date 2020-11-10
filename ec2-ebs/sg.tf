resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  description = "Allow SSH inbound traffic"
  #vpc_id = aws_default_vpc.default.id
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}

#resource "aws_default_vpc" "default" {
#  tags = {
#    Name = "Default VPC"
#  }
#}

