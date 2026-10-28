output "alb_dns_name" {
  description = "Open this URL in a browser to test the app"
  value       = "http://${aws_lb.alb.dns_name}"
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "rds_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "rds_publicly_accessible" {
  value = aws_db_instance.db.publicly_accessible
}

output "cloudtrail_bucket" {
  value = aws_s3_bucket.trail.id
}

output "flow_log_group" {
  value = aws_cloudwatch_log_group.flow.name
}
