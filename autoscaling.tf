resource "aws_launch_template" "web" {
  name_prefix   = "${var.project_name}-web-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = 8
      volume_type           = "gp3"
      encrypted             = true
      kms_key_id            = "arn:aws:kms:eu-west-3:626963114766:key/44400b76-39aa-4b2e-afb9-d680b0d1626f"
      delete_on_termination = true
    }
  }
  metadata_options {
    http_tokens = "required"
  }

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

resource "aws_autoscaling_group" "web" {
  name = "${var.project_name}-asg"

  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  vpc_zone_identifier = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  target_group_arns = [
    aws_lb_target_group.web.arn
  ]

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 120

  tag {
    key                 = "Name"
    value               = "${var.project_name}-autoscaling-web"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_policy" "web_cpu" {
  name                   = "${var.project_name}-cpu-scaling"
  autoscaling_group_name = aws_autoscaling_group.web.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}