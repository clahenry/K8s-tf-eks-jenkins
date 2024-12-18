terraform {
  backend "s3" {
    bucket = "jenkins-terraform-kubernetes-app-2024-v2-henry"
    region = "us-east-1"
    key    = "eks/terraform.tfstate"
  }
}
