# variables.tf

# Project name (used for naming AWS resources)
variable "project_name" {
  description = "Name prefix for AWS resources"
  type        = string
  default     = "tech-challenge"   # change if you want
}

# Environment (used in tags like dev, staging, prod)
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

# AWS region
variable "aws_region" {
  description = "AWS region to deploy infrastructure"
  type        = string
  default     = "us-east-2"
}

# VPC CIDR
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
