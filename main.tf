module "tls_private_key" {
  source = "github.com/SVestor/tf-hashicorp-tls-keys"
  algorithm   = var.algorithm
}

module "gke_cluster" {
  source           = "github.com/SVestor/tf-google-gke-cluster?ref=gke-kbot"
  GOOGLE_REGION    = var.GOOGLE_REGION
  GOOGLE_PROJECT   = var.GOOGLE_PROJECT
  GKE_NUM_NODES    = var.GKE_NUM_NODES
  GKE_CLUSTER_NAME = var.GKE_CLUSTER_NAME
  GKE_MACHINE_TYPE = var.GKE_MACHINE_TYPE
}

module "github_repository" {
  source                   = "github.com/SVestor/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux"
  commit_message           = var.commit_message
  commit_author            = var.commit_author
  commit_email             = var.commit_email
}

module "gke_auth" {
  depends_on = [
    module.gke_cluster
  ]
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version              = ">= 24.0.0"
  project_id           = var.GOOGLE_PROJECT
  cluster_name         = var.GKE_CLUSTER_NAME
  location             = var.GOOGLE_REGION
}

module "flux_bootstrap" {
  source            = "github.com/SVestor/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  github_token      = var.GITHUB_TOKEN
  target_path       = var.target_path
  config_host       = module.gke_auth.host
  config_token      = module.gke_auth.token
  config_ca         = module.gke_auth.cluster_ca_certificate
}

terraform {
  cloud {
    organization = "sv-aws"

    workspaces {
      name = "kbot-wsp"
    }
  }
}
