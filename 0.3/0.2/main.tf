provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "workspaces-example/s3/terraform.tfstate"
    # terraform workspace new example1
    # terraform workspace list
    # terraform workspace select

    # terraform init -backend-config=backend.hcl
  }
}

resource "aws_instance" "example" {
  ami = "ami-smth"
  instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}