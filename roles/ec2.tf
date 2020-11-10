provider "aws" {
  region  = "ap-south-1"
}

resource "aws_instance" "role-example" {
  ami           = "ami-03f0fd1a2ba530e75"
  instance_type = "t2.micro"
  key_name 		= "aws"
  tags = {
     Name 		= "ec2-role-example"
  }

  iam_instance_profile= aws_iam_instance_profile.ec2_profile.name
 }
