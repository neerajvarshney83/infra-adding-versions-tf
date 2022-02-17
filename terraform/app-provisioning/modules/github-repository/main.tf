provider "github" {
  organization = var.github_organization
  token        = var.github_token
}

resource "github_repository" "repository" {
  name               = var.repository_name
  description        = var.repository_description
  allow_merge_commit = false
  allow_rebase_merge = false
  allow_squash_merge = true
  visibility         = "private"
  auto_init          = true
}

resource "github_branch" "branch" {
  branch     = var.default_branch_name
  repository = github_repository.repository.name
}

resource "github_branch_default" "default" {
  repository = github_repository.repository.name
  branch     = github_branch.branch.branch
}

resource "github_repository_file" "gitignore" {
  repository          = github_repository.repository.name
  branch              = github_branch.branch.branch
  file                = ".gitignore"
  content             = var.gitignore_content != null ? var.gitignore_content : file("${path.module}/.gitignore")
  commit_message      = "Initial .gitignore file"
  commit_author       = "Terraform User"
  commit_email        = "terraform@terraform.com"
  overwrite_on_create = false
}

resource "github_repository_file" "codeowners" {
  repository          = github_repository.repository.name
  branch              = github_branch.branch.branch
  file                = "CODEOWNERS"
  content             = var.codeowners_content != null ? var.codeowners_content : file("${path.module}/CODEOWNERS")
  commit_message      = "Initial CODEOWNERS file"
  commit_author       = "Terraform User"
  commit_email        = "terraform@terraform.com"
  overwrite_on_create = false
}

data "github_team" "backend" {
  slug = var.backend_team_name
}

data "github_team" "bots" {
  slug = var.bots_team_name
}

data "github_team" "engineering" {
  slug = var.engineering_team_name
}

data "github_team" "platform" {
  slug = var.platform_team_name
}

resource "github_team_repository" "backend" {
  repository = github_repository.repository.name
  team_id    = data.github_team.backend.id
  permission = "admin"
}

resource "github_team_repository" "bots" {
  repository = github_repository.repository.name
  team_id    = data.github_team.bots.id
  permission = "push"
}

resource "github_team_repository" "engineering" {
  repository = github_repository.repository.name
  team_id    = data.github_team.engineering.id
  permission = "pull"
}

resource "github_team_repository" "platform" {
  repository = github_repository.repository.name
  team_id    = data.github_team.platform.id
  permission = "admin"
}

resource "github_branch_protection" "default" {
  repository_id       = github_repository.repository.id
  pattern             = github_branch_default.default.branch
  enforce_admins      = true
  allows_deletions    = false
  allows_force_pushes = false

  required_status_checks {
    strict   = true
    contexts = ["Test"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }
}
