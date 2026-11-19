variable "project_name" {
  description = "Project name"
  type        = string
}

variable "aws_region" {
  description = "Région AWS dans laquelle déployer l'infrastructure"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
}

variable "min_size" {
  description = "Nombre minimum d'instances dans l'Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Nombre souhaité d'instances dans l'Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Nombre maximum d'instances dans l'Auto Scaling Group"
  type        = number
}

variable "vpc_cidr" {
  description = "Plage CIDR du VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "CIDR du subnet public A"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "CIDR du subnet public B"
  type        = string
}