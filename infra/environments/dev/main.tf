terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
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
  callback_urls         = ["http://localhost:8501"]
  logout_urls           = ["http://localhost:8501"]
  tags                  = local.tags
} 