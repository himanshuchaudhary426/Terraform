resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-east-1b"
  size              = 5
  type = "gp2"
  tags={
  	Name = "new-ebs"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.ebs-ec2.id
}