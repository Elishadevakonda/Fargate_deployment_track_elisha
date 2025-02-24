output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

output "public_subnet_1_id" {
  description = "ID of Public Subnet 1"
  value       = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "ID of Public Subnet 2"
  value       = aws_subnet.public_2.id
}

output "private_subnet_id" {
  description = "ID of Private Subnet"
  value       = aws_subnet.private.id
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.main.name
}

output "ecr_repository_microservice_url" {
  description = "ECR Repository URL for Microservice"
  value       = aws_ecr_repository.my_ecr.repository_url
}

output "ecr_repository_patient_service_url" {
  description = "ECR Repository URL for Patient Service"
  value       = aws_ecr_repository.my_ecr_patient-service.repository_url
}

output "ecr_repository_appointment_service_url" {
  description = "ECR Repository URL for Appointment Service"
  value       = aws_ecr_repository.my_ecr_appointment-service.repository_url
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "alb_id" {
  description = "ID of the Application Load Balancer"
  value       = aws_lb.alb.id
}

output "alb_dns_name" {
  description = "DNS Name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "alb_target_group_arn" {
  description = "ARN of the ALB Target Group"
  value       = aws_lb_target_group.ecs_tg.arn
}

output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.s3_bucket.id
}

output "dynamodb_table_name" {
  description = "DynamoDB Table Name"
  value       = aws_dynamodb_table.terraform_lock.name
}
