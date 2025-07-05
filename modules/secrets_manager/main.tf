resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db-credentials-v5"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username,
    password = var.db_password,
    host     = var.db_host,
    port     = var.db_port,
    dbname   = var.db_name
  })
}
