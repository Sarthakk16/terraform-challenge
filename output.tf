output "web_server_ip" {
  description = "Public IP of the Web Server"
  value       = aws_instance.web.public_ip
}

output "rds_endpoint" {
  description = "RDS MySQL Database Endpoint"
  value       = aws_db_instance.mysql.endpoint
}
