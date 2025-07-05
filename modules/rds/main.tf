module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier        = "support-portal-db"
  engine            = "postgres"
  engine_version    = "15.13"
  instance_class    = "db.t3.medium"
  allocated_storage = 20
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password
  port              = 5432
  family            = "postgres15"
  vpc_security_group_ids = var.security_groups
  subnet_ids             = var.subnet_ids

  skip_final_snapshot = true
  tags = var.tags
}
