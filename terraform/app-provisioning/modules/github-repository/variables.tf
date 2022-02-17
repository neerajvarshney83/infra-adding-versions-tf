
variable "github_token" {
  type = string
  description = "The OAuth token used to authorize GitHub API calls"
}

variable "repository_name" {
  type = string
  description = "Repository name to manage"
}

variable "repository_description" {
  type = string
  description = "Repository description"
}

variable "github_organization" {
  default = "gen6-ventures"
  type = string
  description = "Optional. GitHub organization with which to connect the provider"
}

variable "default_branch_name" {
  type = string
  description = "Optional. The name of a repositories default branch"
  default = "master"
}

variable "gitignore_content" {
  type = string
  description = "Optional. Content of the .gitignore file. If not supplied a default version will be applied."
  default = null
}

variable "codeowners_content" {
  type = string
  description = "Optional. Content of the CODEOWNERS file. If not supplied a default version will be applied."
  default = null
}

variable "backend_team_name" {
  type = string
  description = "Optional. The slug of the backend development team"
  default = "back-end"
}

variable "bots_team_name" {
  type = string
  description = "Optional. The slug of the bots team"
  default = "bots"
}

variable "engineering_team_name" {
  type = string
  description = "Optional. The slug of the engineering team"
  default = "engineering-team"
}

variable "platform_team_name" {
  type = string
  description = "Optional. The slug of the platform team"
  default = "platform"
}
