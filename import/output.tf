output "lb_address" {
  value = "${aws_alb.web.public_dns}"
}

output "instance_ips" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "password" {
  sensitive = true
  value = ["${var.secret_password}"]
}