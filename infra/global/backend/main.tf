provider "aws" {
  region = "eu-west-2"
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "osmanolad-tf-state" 
  
  
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "ecs-terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST" # Cost-conscious setting 
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
