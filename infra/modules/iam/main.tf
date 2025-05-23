terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "aws_iam_policy_document" "cognito_authenticated" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      var.bucket_arn,
      "${var.bucket_arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "cognito_authenticated" {
  name   = "cognito-authenticated-policy"
  role   = aws_iam_role.cognito_authenticated.id
  policy = data.aws_iam_policy_document.cognito_authenticated.json
}

resource "aws_iam_role" "cognito_authenticated" {
  name = "cognito-authenticated-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = "cognito-identity.amazonaws.com"
        }
        Condition = {
          StringEquals = {
            "cognito-identity.amazonaws.com:aud" = var.identity_pool_id
          }
        }
      }
    ]
  })

  tags = var.tags
} 