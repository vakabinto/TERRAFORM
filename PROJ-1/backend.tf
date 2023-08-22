terraform {
  backend "s3" {
    bucket = "mybucket-terra4m"
    key    = "terraform-state/backend"
    region = "us-east-1"
  }
}
