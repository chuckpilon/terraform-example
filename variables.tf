variable "resource_prefix" {
  type  = string
  description = "Prefix used when naming resources"
}

variable "project_name" {
  type        = string
  description = "Project name used to tag resources. May only contain unicode letters, digits, whitespace, or one of these symbols: _ . : / = + - @"
}

variable "client_name" {
  type        = string
  description = "Client name to tag resources. May only contain unicode letters, digits, whitespace, or one of these symbols: _ . : / = + - @"
}

variable "aws_region" {
  type        = string
  description = "AWS region for resources. May only contain unicode letters, digits, whitespace, or one of these symbols: _ . : / = + - @"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile to use when creating the EC2 instance"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for VPC"
}

# TODO: Make these an array
variable "subnet1_cidr_block" {
  type        = string
  description = "CIDR block for subnet 1"
}

variable "subnet2_cidr_block" {
  type        = string
  description = "CIDR block for subnet 2"
}

variable "subnet3_cidr_block" {
  type        = string
  description = "CIDR block for subnet 3"
}

# variable "availability_zones" {
#   type        = list(string)
#   description = "Availability zones"
# }

variable "rds_instance_name" {
  type        = string
  description = "Name of the RDS instance"
}

variable "rds_instance_class" {
  type        = string
  description = "RDS instance class (e.g. db.t2.micro)"
}

variable "rds_master_username" {
  type        = string
  description = "RDS master user name"
}

variable "rds_master_password" {
  type        = string
  description = "RDS master user password"
}
