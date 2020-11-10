
resource "aws_instance" "linux" {
	instance_type = "t2.micro"
	ami = "ami-0e306788ff2473ccb"
}