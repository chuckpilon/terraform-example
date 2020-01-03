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

variable "environment" {
  type        = string
  description = "Environment to tag resources, such as Development, Test, Preview, or Production. May only contain unicode letters, digits, whitespace, or one of these symbols: _ . : / = + - @"
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

variable "instance_name" {
  type        = string
  description = "Name of the RDS instance"
}

variable "database_name" {
  type        = string
  description = "(Optional) The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance."
  default     = null
}

variable "storage_type" {
  type        = string
  description = "(Optional) One of \"standard\" (magnetic), \"gp2\" (general purpose SSD), or \"io1\" (provisioned IOPS SSD). The default is \"io1\" if iops is specified, \"gp2\" if not."
  default     = null
}

variable "iops" {
  type        = string
  description = "(Optional) The amount of provisioned IOPS. Setting this implies a storage_type of \"io1\"."
  default     = null
}

variable "instance_class" {
  type        = string
  description = "RDS instance class (e.g. db.t2.micro)"
}

variable "initial_allocated_storage" {
  type        = number
  description = "The initial storage allocation in gibibytes"
}

variable "max_allocated_storage" {
  type        = number
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Must be greater than or equal to rds_initial_allocated_storage or 0 to disable Storage Autoscaling."
}

variable "master_username" {
  type        = string
  description = "RDS master user name"
}

variable "master_password" {
  type        = string
  description = "RDS master user password"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "RDS security group ingress CIDR block"
}

variable "backup_window" {
  type        = string
  description = "(Optional) The daily time range (in UTC) during which automated backups are created if they are enabled. Example: \"09:46-10:16\". Must not overlap with maintenance_window."
  default     = null
}

variable "maintenance_window" {
  type        = string
  description = "(Optional) The window to perform maintenance in. Syntax: \"ddd:hh24:mi-ddd:hh24:mi\". Eg: \"Mon:00:00-Mon:03:00\"."
  default     = null
}

variable "cloudwatch_logs_exports" {
  type        = list(string)
  description = "(Optional) List of log types to enable for exporting to CloudWatch logs. Valid values: audit, error, general, slowquery, trace"
  default     = null
}

variable "engine_version" {
  type        = string
  description = "The MySQL engine version to use."
}

variable "option_group_name" {
  type        = string
  description = "Name of the DB option group to associate."
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the DB parameter group to associate."
}

variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica."
}

variable "monitoring_interval" {
  type        = number
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = 0
}

variable "availability_zone" {
  type        = string
  description = "(Optional) The AZ for the RDS instance. Leave unset if rds_multi_az is true."
  default     = null
}

variable "multi_az" {
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ"
}

variable "publicly_accessible" {
  type        = bool
  description = "(Optional) Bool to control if instance is publicly accessible. Default is false"
  default     = false
}

variable "iam_database_authentication_enabled" {
  type        = bool
  description = "(Optional) Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled."
  default     = false
}

variable "copy_tags_to_snapshot" {
  type = bool
  description = "(Optional) Copy all Instance tags to snapshots. Default is false."
  default = false
}

variable "skip_final_snapshot" {
  type = bool
  description = "(Optional) Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier. Default is false."
  default = false
}

variable "final_snapshot_identifier" {
  type = string
  description = "(Optional) The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip_final_snapshot is set to false."
  default = false
}
