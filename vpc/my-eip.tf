resource "aws_eip" "nat-ip" {
	tags = {
	Name = "nat-ip"
	}
}