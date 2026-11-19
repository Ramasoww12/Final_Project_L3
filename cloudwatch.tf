resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  alarm_name        = "${var.project_name}-ec2-cpu-high"
  alarm_description = "Alerte lorsque le CPU moyen des instances EC2 est élevé"

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }

  treat_missing_data = "notBreaching"
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title = "CPU moyen des instances Auto Scaling"

          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              aws_autoscaling_group.web.name
            ]
          ]

          period = 60
          stat   = "Average"
          region = "eu-west-3"

          view    = "timeSeries"
          stacked = false
        }
      }
    ]
  })
}