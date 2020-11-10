provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = " ami-03f0fd1a2ba530e75"
  instance_type = "t2.micro"
  key_name = "aws"
  tags = {
  	Name = "myec3"
  }
}