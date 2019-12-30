provider "aws" {
  version = "~> 2.43"
  profile = var.aws_profile
  region  = var.aws_region
}

# aws_vpc.vpc:
resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name        = "${var.resource_prefix}_vpc"
    Client      = var.client_name
    Application = var.application_name
    Environment = var.environment
  }
}

# Create one subnet for each given availability zone.
# Built-in functions and operators can be used for simple transformations of
# values, such as computing a subnet address. Here we create a /20 prefix for
# each subnet, using consecutive addresses for each availability zone,
# such as 10.1.16.0/20 .

# aws_subnet.subnet
resource "aws_subnet" "subnet" {
  count                           = length(var.availability_zones)
  assign_ipv6_address_on_creation = false
  map_public_ip_on_launch         = true
  availability_zone               = var.availability_zones[count.index]
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index + 1)

  tags = {
    Name        = "${var.resource_prefix}_subnet_${count.index}"
    Client      = var.client_name
    Application = var.application_name
    Environment = var.environment
  }
}

# aws_db_subnet_group.db_subnet_group:
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.resource_prefix}_db_subnet_group"
  description = "Database subnet group for ${var.resource_prefix}_rds"
  subnet_ids  = flatten([aws_subnet.subnet.*.id])

  tags = {
    Name        = "${var.resource_prefix}_db_subnet_group"
    Client      = var.client_name
    Application = var.application_name
    Environment = var.environment
  }
}

# aws_default_route_table.rt
resource "aws_default_route_table" "rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route = [
    {
      cidr_block                = "0.0.0.0/0"
      egress_only_gateway_id    = ""
      gateway_id                = aws_internet_gateway.gw.id
      instance_id               = ""
      ipv6_cidr_block           = ""
      nat_gateway_id            = ""
      network_interface_id      = ""
      transit_gateway_id        = ""
      vpc_peering_connection_id = ""
    },
  ]

  tags = {
    Name        = "${var.resource_prefix}_default_route_table"
    Client      = var.client_name
    Application = var.application_name
    Environment = var.environment
  }
}

# aws_internet_gateway.gw:
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.resource_prefix}_gw"
    Client      = var.client_name
    Application = var.application_name
    Environment = var.environment
  }
}

# aws_security_group.rds_sg:
resource "aws_security_group" "rds_sg" {
  description = "VPC security group for ${var.resource_prefix}_rds"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks      = var.rds_ingress_cidr_blocks
      description      = ""
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3306
    },
  ]
  name   = "${var.resource_prefix}_rds_sg"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.resource_prefix}_rds_sg"
    Client      = var.client_name
    Application = var.application_name
    Environment = var.environment
  }
}

resource "aws_db_instance" "rds" {
  # Engine Options
  engine                                = "mysql"
  engine_version                        = var.rds_engine_version

  # Settings
  identifier                            = var.rds_instance_name
  username                              = var.rds_master_username
  password                              = var.rds_master_password

  # Database instance size
  instance_class                        = var.rds_instance_class

  # Storage
  storage_type                          = var.rds_storage_type
  iops                                  = var.rds_iops
  allocated_storage                     = var.rds_initial_allocated_storage
  max_allocated_storage                 = var.rds_max_allocated_storage

  # Availability & durability
  multi_az                              = var.rds_multi_az

  # Connectivity
  vpc_security_group_ids                = [aws_security_group.rds_sg.id]
  db_subnet_group_name                  = aws_db_subnet_group.db_subnet_group.id
  publicly_accessible                   = var.rds_publicly_accessible
  port                                  = 3306

  # Database authentication
  iam_database_authentication_enabled   = var.rds_iam_auth

  # Database options
  name                                  = var.rds_database_name
  parameter_group_name                  = var.rds_parameter_group_name
  option_group_name                     = var.rds_option_group_name

  # Backup
  backup_window                         = var.rds_backup_window
  backup_retention_period               = var.rds_backup_retention_period
  copy_tags_to_snapshot                 = var.rds_copy_tags_to_snapshot
  skip_final_snapshot                   = var.rds_skip_final_snapshot
  
  # Encryption
  storage_encrypted                     = false

  # Performance Insights
  performance_insights_enabled          = false
  performance_insights_retention_period = 0

  # Monitoring
  monitoring_interval                   = var.rds_monitoring_interval
  enabled_cloudwatch_logs_exports       = var.rds_cloudwatch_logs_exports

  # Maintenance
  auto_minor_version_upgrade            = false
  maintenance_window                    = var.rds_maintenance_window

  # Deletion protection
  deletion_protection                   = false

  # TODO?
  # apply_immediately
  # availability_zone
  # ca_cert_identifier
  # domain
  # domain_iam_role_name
  # final_snapshot_identifier
  # identifier_prefix
  # kms_key_id 
  # monitoring_role_arn 
  # replicate_source_db
  # snapshot_identifier 
  # s3_import
  # performance_insights_kms_key_id
  # 
  # 
  # 
  # 

  tags = {
    Name        = "${var.resource_prefix}_rds"
    Client      = var.client_name
    Application = var.application_name
    Environment = var.environment
  }
}
