terraform {
  backend "gcs" {
    bucket = "terraform_task1_sith123"
    prefix = "tfstate"
    credentials = "cred.json"
  }
}
