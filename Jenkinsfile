pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'

        FRONTEND_REPO = '550054567146.dkr.ecr.us-east-1.amazonaws.com/devops-frontend'
        BACKEND_REPO  = '550054567146.dkr.ecr.us-east-1.amazonaws.com/devops-backend'

        ECS_CLUSTER = 'devops-challenge-cluster'
        FRONTEND_SERVICE = 'devops-challenge-frontend'
        BACKEND_SERVICE  = 'devops-challenge-backend'
    }

    stages {

        stage('Checkout code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker images') {
            steps {
                sh '''
                    docker build -t frontend:latest ./frontend
                    docker build -t backend:latest ./backend
                '''
            }
        }

        stage('Authenticate to ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-devops-challenge']]) {
                    sh '''
                        aws --version

                        aws ecr get-login-password --region "$AWS_REGION" | \
                        docker login --username AWS --password-stdin "$FRONTEND_REPO"

                        aws ecr get-login-password --region "$AWS_REGION" | \
                        docker login --username AWS --password-stdin "$BACKEND_REPO"
                    '''
                }
            }
        }

        stage('Tag and Push images to ECR') {
            steps {
                sh '''
                    docker tag frontend:latest "$FRONTEND_REPO:latest"
                    docker tag backend:latest "$BACKEND_REPO:latest"

                    docker push "$FRONTEND_REPO:latest"
                    docker push "$BACKEND_REPO:latest"
                '''
            }
        }

        stage('Update ECS services') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-devops-challenge']]) {
                    sh '''
                        aws ecs update-service \
                            --cluster "$ECS_CLUSTER" \
                            --service "$FRONTEND_SERVICE" \
                            --force-new-deployment \
                            --region "$AWS_REGION"

                        aws ecs update-service \
                            --cluster "$ECS_CLUSTER" \
                            --service "$BACKEND_SERVICE" \
                            --force-new-deployment \
                            --region "$AWS_REGION"
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
