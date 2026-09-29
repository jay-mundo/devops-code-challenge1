variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for AWS resource naming"
  type        = string
  default     = "devops-challenge"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ecr_frontend_repo_name" {
  description = "Existing ECR repository name for the frontend"
  type        = string
  default     = "devops-frontend"
}

variable "ecr_backend_repo_name" {
  description = "Existing ECR repository name for the backend"
  type        = string
  default     = "devops-backend"
}