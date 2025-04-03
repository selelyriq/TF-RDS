terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


###########################################################
# Create RDS Instance
###########################################################

resource "aws_db_instance" "RDS" {
  identifier = var.identifier
  engine = var.engine
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  username = var.username
  password = local.secret_string.password
  skip_final_snapshot = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  snapshot_identifier = var.snapshot_identifier
  tags = var.tags
}

###########################################################
# Create a random password for the RDS instance.
###########################################################

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

###########################################################
# Create RDS Secret
###########################################################

resource "aws_secretsmanager_secret" "RDS_Secret" {
  name = "RDS_Secret"
  description = "Secret for RDS"
  tags = var.tags
}

###########################################################
# Create RDS Secret Version, this sets the password for the RDS instance. Using a random password.
###########################################################

resource "aws_secretsmanager_secret_version" "RDS_Secret_Version" {
  secret_id = aws_secretsmanager_secret.RDS_Secret.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.password.result
  })
}

###########################################################
# Get the RDS Secret Version, this is used to get the password for the RDS instance.
###########################################################

data "aws_secretsmanager_secret_version" "RDS_Secret_Version" {
  secret_id = aws_secretsmanager_secret.RDS_Secret.id

  depends_on = [aws_secretsmanager_secret_version.RDS_Secret_Version]
}

###########################################################
# Get the RDS Secret Version, and decode the secret string.
###########################################################

locals {
    secret_string = jsondecode(data.aws_secretsmanager_secret_version.RDS_Secret_Version.secret_string)
}
