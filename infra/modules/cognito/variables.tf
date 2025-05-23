variable "user_pool_name" {
  description = "Name of the Cognito User Pool"
  type        = string
}

variable "callback_urls" {
  description = "List of callback URLs for the User Pool Client"
  type        = list(string)
  default     = ["http://localhost:8501"]
}

variable "logout_urls" {
  description = "List of logout URLs for the User Pool Client"
  type        = list(string)
  default     = ["http://localhost:8501"]
}

variable "authenticated_role_arn" {
  description = "ARN of the IAM role for authenticated users"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Cognito resources"
  type        = map(string)
  default     = {}
} 