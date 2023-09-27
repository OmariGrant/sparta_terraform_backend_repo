# provider "github" {
#   token = var.sparta_github_token
#   alias = "sparta_github"
# }

resource "github_repository" "terraform_backend_repo" {
  name = "sparta_terraform_backend_repo1"
  description = "sparta_terraform_backend_repo"
  visibility = "public"
}