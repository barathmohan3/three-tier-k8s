resource "aws_ecr_repository" "frontend" {
  name = "support-portal-frontend"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "backend" {
  name = "support-portal-backend"
  image_tag_mutability = "MUTABLE"
}
