resource "aws_ebs_snapshot" "my_snapshot" {
  volume_id = aws_ebs_volume.ebs.id

  tags = {
    Name = "my_snap"
  }
}
