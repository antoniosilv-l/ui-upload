terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "ui-upload-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = "dev"
      Project     = "ui-upload"
      ManagedBy   = "terraform"
    }
  }
}

locals {
  environment = "dev"
  tags = {
    Environment = local.environment
    Project     = "ui-upload"
    ManagedBy   = "terraform"
  }
}

module "s3" {
  source = "../../modules/s3"

  bucket_name = "ui-upload-${local.environment}"
  tags        = local.tags
}

module "iam" {
  source = "../../modules/iam"

  bucket_arn        = module.s3.bucket_arn
  identity_pool_id  = module.cognito.identity_pool_id
  tags             = local.tags
}

module "cognito" {
  source = "../../modules/cognito"

  user_pool_name        = "ui-upload-${local.environment}"
  authenticated_role_arn = module.iam.role_arn
  callback_urls         = [
    "https://localhost:8501",
    "https://localhost:8501/",
    "https://127.0.0.1:8501",
    "https://127.0.0.1:8501/",
    "https://*.ngrok-free.app",
    "https://*.ngrok.io/"
  ]
  logout_urls           = [
    "https://localhost:8501",
    "https://localhost:8501/",
    "https://127.0.0.1:8501",
    "https://127.0.0.1:8501/",
    "https://*.ngrok-free.app",
    "https://*.ngrok.io/"
  ]
  tags                  = local.tags
}
