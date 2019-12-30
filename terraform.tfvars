# Some IDEs will errorneously show errors in this file, such as "An argument named "aws_region" is not expected here."
# See https://github.com/mauve/vscode-terraform/issues/218 and https://github.com/juliosueiras/terraform-lsp/issues/39.

resource_prefix  = "acme_app1"
client_name      = "Acme Inc."
application_name = "Application 1"
environment      = "Development"

aws_region         = "us-east-2"
availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
aws_profile        = "default"

vpc_cidr_block = "172.30.0.0/16"

rds_instance_name             = "acme-app1"
rds_database_name             = null
rds_instance_class            = "db.t2.micro"
rds_initial_allocated_storage = 20
rds_max_allocated_storage     = 1000
rds_master_username           = "root"
rds_master_password           = "megasecretpassword"
rds_ingress_cidr_blocks       = ["192.94.40.70/32"]
rds_backup_window             = "01:00-02:00"
rds_maintenance_window        = "wed:04:45-wed:05:15"
rds_cloudwatch_logs_exports   = ["audit", "error", "general", "slowquery"]
rds_engine_version            = "5.7.22"
rds_option_group_name         = "default:mysql-5-7"
rds_parameter_group_name      = "default.mysql5.7"
rds_backup_retention_period   = 0
rds_monitoring_interval       = 0
rds_multi_az                  = true
rds_storage_type              = "gp2"
rds_publicly_accessible       = true
rds_skip_final_snapshot       = false
