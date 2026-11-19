resource "aws_key_pair" "project" {
  key_name   = "${var.project_name}-key"
  public_key = file("C:/Users/hp/.ssh/terraform-project-key.pub")

  tags = {
    Name = "${var.project_name}-key"
  }
}