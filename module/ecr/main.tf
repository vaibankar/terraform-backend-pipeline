
resource "aws_ecr_repository" "ecr" {
    name = var.ecr_name
    image_tag_mutability = var.image_tag_mutability
    encryption_configuration {
      encryption_type = var.encryption_type
    }
    image_scanning_configuration {
      scan_on_push = true
    }


  tags = {
    name        = "${var.environment}-${var.project}-ecr"
    Environment = var.environment
    project     = var.project
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecr.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description   = "keep last 30 images"
      selection     = {
        tagStatus = "tagged"
        tagPrefixList = ["v"]
        countType = "sinceImagePushed"
        countUnit = "days"
        countNumber = 30
      }
      action = {
        type = "expire"
      }
    }]
  })
}

