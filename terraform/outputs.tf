# =========================================================
# VPC OUTPUTS
# =========================================================

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}


# =========================================================
# SUBNET OUTPUTS
# =========================================================

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}


# =========================================================
# NAT GATEWAY OUTPUT
# =========================================================

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.main.id
}


# =========================================================
# ECR OUTPUTS
# =========================================================

output "frontend_repository_url" {
  description = "URL of the frontend ECR repository"
  value       = aws_ecr_repository.frontend.repository_url
}

output "backend_repository_url" {
  description = "URL of the backend ECR repository"
  value       = aws_ecr_repository.backend.repository_url
}


# =========================================================
# ALB OUTPUTS
# =========================================================

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = aws_lb.main.zone_id
}


# =========================================================
# ECS OUTPUTS
# =========================================================

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.main.arn
}


# =========================================================
# JENKINS OUTPUTS
# =========================================================

output "jenkins_master_public_ip" {
  description = "Public IP address of the Jenkins master"
  value       = aws_eip.jenkins_master.public_ip
}

output "jenkins_master_instance_id" {
  description = "Instance ID of the Jenkins master"
  value       = aws_instance.jenkins_master.id
}

output "jenkins_url" {
  description = "URL to access Jenkins"
  value       = "http://${aws_eip.jenkins_master.public_ip}:8080"
}


# =========================================================
# SECURITY GROUP OUTPUTS
# =========================================================

output "jenkins_security_group_id" {
  description = "ID of the Jenkins security group"
  value       = aws_security_group.jenkins.id
}

output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb_sg.id
}

output "ecs_security_group_id" {
  description = "ID of the ECS frontend security group"
  value       = aws_security_group.ecs_sg.id
}

output "backend_security_group_id" {
  description = "ID of the backend security group"
  value       = aws_security_group.backend.id
}


# =========================================================
# IAM OUTPUT
# =========================================================

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}