provider "aws"{
	region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "himanshu426"
    key    = "state"
    region = "us-east-1"
  }
}


resource "aws_instance" "ebs-ec2" {
  ami           = "ami-0dba2cb6798deb6d8"
  instance_type = "t2.micro"
  #availability_zone = "us-east-1b"
  #security_groups = [aws_security_group.my-sg.id]
  #vpc_security_group_ids = [aws_security_group.my-sg.id]
  key_name = "ebs"
  #user_data = file("script.sh")
  tags = {
    Name = "ebs-ec2"
  }
}
