terraform {
  backend "s3" {
    bucket         = "aws-fargate-deployment-track" 
    key            = "elisha/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "aws-fargate-deployment-track"
  }
}
