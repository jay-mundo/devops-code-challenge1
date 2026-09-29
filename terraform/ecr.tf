# ============================================================
# ECR REPOSITORIES
# ============================================================

resource "aws_ecr_repository" "frontend" {
  name                 = var.ecr_frontend_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.project_name}-frontend-repo"
    Environment = var.environment
  }
}

resource "aws_ecr_repository" "backend" {
  name                 = var.ecr_backend_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.project_name}-backend-repo"
    Environment = var.environment
  }
}


# ============================================================
# ECR LIFECYCLE POLICY - FRONTEND
# ============================================================

resource "aws_ecr_lifecycle_policy" "frontend" {
  repository = aws_ecr_repository.frontend.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 5 tagged images"

        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 5
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}


# ============================================================
# ECR LIFECYCLE POLICY - BACKEND
# ============================================================

resource "aws_ecr_lifecycle_policy" "backend" {
  repository = aws_ecr_repository.backend.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 5 tagged images"

        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 5
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}