resource "aws_launch_template" "web" {
  name_prefix   = "${var.project_name}-web-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.project.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    html_content = file("${path.module}/web/index.html")
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-autoscaling-web"
    }
  }
}