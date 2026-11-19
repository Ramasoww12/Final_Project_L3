resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public_a.id

  key_name = aws_key_pair.project.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]
  user_data = templatefile("${path.module}/user_data.sh", {
    html_content = file("${path.module}/web/index.html")
  })

  tags = {
    Name = "${var.project_name}-web"
  }
}

