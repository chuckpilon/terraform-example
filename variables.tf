variable "aws_region" {
  type        = string
  description = "AWS region for the EC2 instance"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile to use when creating the EC2 instance"
}

variable "ami" {
  type        = string
  description = "AMI for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Type for the EC2 instance"
}

variable "instance_name" {
  type        = string
  description = "Name of the EC2 instance"
}