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
  }
}

# aws_internet_gateway.gw:
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.resource_prefix}_gw"
    Client      = var.client_name
    Application = var.application_name
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
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage                     = var.rds_initial_allocated_storage
  auto_minor_version_upgrade            = false
  availability_zone                     = var.availability_zones[0]
  backup_retention_period               = 0
  backup_window                         = var.rds_backup_window
  copy_tags_to_snapshot                 = true
  db_subnet_group_name                  = aws_db_subnet_group.db_subnet_group.id
  deletion_protection                   = false
  enabled_cloudwatch_logs_exports       = var.rds_cloudwatch_logs_exports
  engine                                = "mysql"
  engine_version                        = var.rds_engine_version
  iam_database_authentication_enabled   = false
  identifier                            = var.rds_instance_name
  instance_class                        = var.rds_instance_class
  iops                                  = 0
  license_model                         = "general-public-license"
  maintenance_window                    = var.rds_maintenance_window
  max_allocated_storage                 = var.rds_max_allocated_storage
  monitoring_interval                   = 0
  multi_az                              = false
  option_group_name                     = var.rds_option_group_name
  password                              = var.rds_master_password
  parameter_group_name                  = var.rds_parameter_group_name
  performance_insights_enabled          = false
  performance_insights_retention_period = 0
  port                                  = 3306
  publicly_accessible                   = true
  security_group_names                  = []
  skip_final_snapshot                   = true
  storage_encrypted                     = false
  storage_type                          = "gp2"
  username                              = var.rds_master_username
  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  tags = {
    Name        = "${var.resource_prefix}_rds"
    Client      = var.client_name
    Application = var.application_name
  }
}
