variable "algorithm" {
  type        = string
  default     = "RSA"
  description = "The cryptographic algorithm (e.g. RSA, ECDSA)"
}

variable "GITHUB_OWNER" {
  type        = string
  description = "The GitHub owner"
  default = ""
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "GitHub personal access token"
  default = ""
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "GitHub repository"
}

variable "GOOGLE_PROJECT" {
  type        = string
  description = "GCP project name"
  default = ""
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1-c"
  description = "GCP region to use"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 2
  description = "GKE nodes number"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  default     = "flux-demo"
  description = "GKE cluster name"
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  default     = "n1-standard-2"
  description = "Machine type"
}

variable "target_path" {
  type        = string
  default     = "clusters"
  description = "Flux manifests subdirectory"
}

variable "commit_message" {
  type        = string
  default     = "Managed by Terraform"
  description = "commit message"
}

variable "commit_author" {
  type        = string
  default     = "Terraform User"
  description = "commit author"
}

variable "commit_email" {
  type        = string
  default     = "terraform@gh.com"
  description = "commit email"
}