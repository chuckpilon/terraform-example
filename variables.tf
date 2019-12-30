variable "resource_prefix" {
  type        = string
  description = "Prefix used when naming resources"
}

variable "application_name" {
  type        = string
  description = "Application name used to tag resources. May only contain unicode letters, digits, whitespace, or one of these symbols: _ . : / = + - @"
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

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "rds_instance_name" {
  type        = string
  description = "Name of the RDS instance"
}

variable "rds_instance_class" {
  type        = string
  description = "RDS instance class (e.g. db.t2.micro)"
}

variable "rds_initial_allocated_storage" {
  type =  string
  description = "The initial storage allocation in gibibytes"
}

variable "rds_max_allocated_storage" {
  type =  string
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Must be greater than or equal to rds_initial_allocated_storage or 0 to disable Storage Autoscaling."
}

variable "rds_master_username" {
  type        = string
  description = "RDS master user name"
}

variable "rds_master_password" {
  type        = string
  description = "RDS master user password"
}

variable "rds_ingress_cidr_blocks" {
  type        = list(string)
  description = "RDS security group ingress CIDR block"
}

variable "rds_backup_window" {
  type        = string
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled."
}

variable "rds_maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: \"ddd:hh24:mi-ddd:hh24:mi\"."
}

variable "rds_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to enable for exporting to CloudWatch logs. Valid values: audit, error, general, slowquery, trace"
}

variable "rds_engine_version" {
  type        = string
  description = "The MySQL engine version to use."
}

variable "rds_option_group_name" {
  type        = string
  description = "Name of the DB option group to associate."
}

variable "rds_parameter_group_name" {
  type        = string
  description = "Name of the DB parameter group to associate."
}
variable "rds_backup_retention_period" {
  type = string
  description = "The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica."
}