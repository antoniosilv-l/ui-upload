variable "bucket_arn" {
  description = "ARN of the S3 bucket"
  type        = string
}

variable "identity_pool_id" {
  description = "ID of the Cognito Identity Pool"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the IAM role"
  type        = map(string)
  default     = {}
} 