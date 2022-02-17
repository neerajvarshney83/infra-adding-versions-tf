variable "repository_name" {
  type = string
  description = "The name of the ECR repository"
}

variable "additional_aws_account_access_id" {
  type = string
  description = "Optional. Additional AWS account ID that has read-only access to the ECR repository"
  default = null
}
