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

instance_name             = "acme-app1"
database_name             = null
instance_class            = "db.t2.micro"
initial_allocated_storage = 20
max_allocated_storage     = 1000
master_username           = "root"
master_password           = "megasecretpassword"
ingress_cidr_blocks       = ["192.94.40.70/32"]
backup_window             = "01:00-02:00"
maintenance_window        = "wed:04:45-wed:05:15"
cloudwatch_logs_exports   = ["audit", "error", "general", "slowquery"]
engine_version            = "5.7.22"
option_group_name         = "default:mysql-5-7"
parameter_group_name      = "default.mysql5.7"
backup_retention_period   = 0
monitoring_interval       = 0
multi_az                  = false
storage_type              = "gp2"
publicly_accessible       = true
skip_final_snapshot       = true
