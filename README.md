# AWS DevOps Challenge
## Project Overview
This project deploys a containerized frontend and backend application to AWS using Terraform, Amazon ECS Fargate, Amazon ECR, an Application Load Balancer, and Jenkins CI/CD.
The application consists of:
- React frontend running on port 3000
- Node.js/Express backend running on port 8080
- Docker containers for both applications
- Amazon ECR for container image storage
- Amazon ECS Fargate for containerized workloads
- Application Load Balancer for public access and traffic routing
- Terraform for infrastructure as code
- Jenkins for CI/CD automation
- ECS Service Auto Scaling based on CPU utilization
## Architecture
```text
                         Internet
                            |
                            v
              Application Load Balancer
                            |
                    +-------+-------+
                    |               |
                    v               v
              Frontend ECS      Backend ECS
              Port 3000         Port 8080
                    |               |
                    +-------+-------+
                            |
                         AWS VPC
                 Public / Private Subnets
                            |
                       NAT Gateway
```
## Technology Stack
### Application
- React
- Node.js
- Express
- JavaScript
### Containers
- Docker
- Amazon ECR
### AWS
- Amazon VPC
- Public and private subnets
- Internet Gateway
- NAT Gateway
- Application Load Balancer
- Amazon ECS
- AWS Fargate
- Amazon CloudWatch
- ECS Service Auto Scaling
### Infrastructure as Code
- Terraform
### CI/CD
- Jenkins
- GitHub
## Prerequisites
Install the following tools before deploying the project:
- Git
- Node.js and npm
- Docker
- AWS CLI
- Terraform
- Jenkins
- AWS account with appropriate IAM permissions
Verify the tools:
```bash
git --version
node --version
npm --version
docker --version
aws --version
terraform version
```
## Project Structure
```text
devops-code-challenge1/
├── backend/
│   ├── Dockerfile
│   ├── index.js
│   ├── config.js
│   ├── package.json
│   └── package-lock.json
├── frontend/
│   ├── Dockerfile
│   ├── src/
│   ├── package.json
│   └── package-lock.json
├── terraform/
├── Jenkinsfile
└── README.md
```
## Local Application Setup
### Backend
```bash
cd backend
npm ci
npm start
```
The backend runs on:
http://localhost:8080
### Frontend
Open another terminal:
```bash
cd frontend
npm ci
npm start
```
The frontend runs on:
http://localhost:3000
## Docker Setup
Build the backend image:
```bash
docker build -t backend ./backend
```
Build the frontend image:
```bash
docker build -t frontend ./frontend
```
Run the backend:
```bash
docker run -d --name backend -p 8080:8080 backend
```
Run the frontend:
```bash
docker run -d --name frontend -p 3000:3000 frontend
```
The ECS deployment uses Linux AMD64 container images because the ECS Fargate workloads run on x86_64 infrastructure.
## AWS Infrastructure
The infrastructure is deployed in:
AWS Region: us-east-1
Terraform provisions:
- VPC
- Public and private subnets across multiple Availability Zones
- Internet Gateway
- NAT Gateway
- Route tables
- Security groups
- Application Load Balancer
- ECS cluster
- ECS services
- ECS task definitions
- ECR repositories
- ECS Service Auto Scaling
## Terraform Deployment
From the Terraform directory:
```bash
cd terraform
```
Initialize Terraform:
```bash
terraform init
```
Review the infrastructure plan:
```bash
terraform plan
```
Apply the infrastructure:
```bash
terraform apply
```
Before applying future infrastructure changes, review the plan with:
```bash
terraform plan
```
## Amazon ECR
Docker images are stored in Amazon Elastic Container Registry.
Repositories:
- devops-frontend
- devops-backend
Example ECR authentication:
```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 550054567146.dkr.ecr.us-east-1.amazonaws.com
```
The Docker images are tagged and pushed to ECR before being deployed to ECS.
## ECS and Fargate
The application runs on Amazon ECS using AWS Fargate.
ECS cluster:
devops-challenge-cluster
ECS services:
- devops-challenge-frontend
- devops-challenge-backend
Task configuration:
- CPU: 0.5 vCPU
- Memory: 1 GB
Application ports:
- Frontend: 3000
- Backend: 8080
The Application Load Balancer provides the public entry point and routes traffic to the ECS services.
## Jenkins CI/CD
Jenkins automates the application deployment process.
The Jenkins pipeline:
1. Checks out the GitHub repository.
2. Builds the frontend Docker image.
3. Builds the backend Docker image.
4. Authenticates with Amazon ECR.
5. Tags the Docker images.
6. Pushes the images to ECR.
7. Forces a new ECS deployment for the frontend service.
8. Forces a new ECS deployment for the backend service.
The pipeline is defined in:
Jenkinsfile
Jenkins job:
TC1
Jenkins URL:
http://52.205.191.40:8080
AWS credentials used by Jenkins are stored in Jenkins Credentials Manager and are not hard-coded into the Jenkinsfile.
## ECS Auto Scaling
The frontend ECS service uses target tracking based on average CPU utilization.
Configuration:
- Minimum tasks: 1
- Maximum tasks: 4
- CPU target: 50%
- Scale-out cooldown: 60 seconds
- Scale-in cooldown: 60 seconds
The scaling policy uses:
ECSServiceAverageCPUUtilization
This allows ECS to automatically adjust the number of frontend tasks based on CPU utilization.
## Load Testing
Siege 4.2.0 was used to test the public application endpoint.
Test configuration:
- Concurrent users: 250
- Duration: 2 minutes
Results:
- Transactions: 20,496
- Availability: 99.97%
- Failed transactions: 6
- Response time: 1.46 seconds
- Transaction rate: 169.94 transactions/sec
- Concurrency: 248.18
- Throughput: 2.32 MB/sec
The load test maintained 99.97% availability while handling approximately 250 concurrent connections.
## Public Application
Frontend:
http://devops-challenge-alb-1765529530.us-east-1.elb.amazonaws.com
Backend API:
http://devops-challenge-alb-1765529530.us-east-1.elb.amazonaws.com/api/
## Cleanup
When the environment is no longer needed, Terraform can be used to remove infrastructure managed by Terraform:
```bash
cd terraform
terraform destroy
```
Review the destruction plan carefully before confirming.
Resources created outside Terraform, such as Jenkins infrastructure, may need to be removed separately.
## Submission
GitHub repository:
https://github.com/jay-mundo/devops-code-challenge1
Jenkins:
http://52.205.191.40:8080
Frontend:
http://devops-challenge-alb-1765529530.us-east-1.elb.amazonaws.com
The repository contains the application source code, Docker configuration, Terraform infrastructure, Jenkins CI/CD pipeline, and deployment documentation.
## Security Note
Do not commit AWS access keys, secret keys, GitHub tokens, Jenkins passwords, or other credentials to the repository.
