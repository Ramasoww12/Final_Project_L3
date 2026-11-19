output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "ec2_id" {
  value = aws_instance.web.id
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.web.private_ip
}

output "ec2_public_dns" {
  value = aws_instance.web.public_dns
}