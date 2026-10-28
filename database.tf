############################
# Database tier: RDS MySQL in private DB subnets
############################
resource "aws_db_subnet_group" "db" {
  name       = "${var.project}-db-subnets"
  subnet_ids = aws_subnet.db[*].id
}

resource "aws_db_instance" "db" {
  identifier        = "${var.project}-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "appdb"
  username = "dbadmin"
  # Password generated and stored in Secrets Manager; never appears in .tf files
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = false
  multi_az               = var.db_multi_az

  storage_encrypted       = true
  backup_retention_period = 7
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot   = true

  # Lab settings: set deletion_protection = true and skip_final_snapshot = false in production
  deletion_protection = false
  skip_final_snapshot = true
}
