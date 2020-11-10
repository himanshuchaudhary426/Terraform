provider "aws" {
	region = "us-east-1"
}



data "aws_ami_ids" "ubuntu" {
  owners = ["self"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}

data "aws_ami" "example" {
  executable_users = ["self"]
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami"{
	value = data.aws_ami_ids.ubuntu.id
}

output "ami-id"{
	value = data.aws_ami.example.id
}