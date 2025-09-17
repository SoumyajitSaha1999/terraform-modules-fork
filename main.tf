provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "ec2" {
  source        = "./modules/ec2-instances"
  ami           = "ami-02ddb77f8f93ca4ca"       # Amazon Linux 2023 in ap-south-1
  instance_type = "t2.micro"
  # Outputs can be Input for main.tf
  subnet_id     = module.vpc.public_subnet_id
}

module "s3" {
  source      = "./modules/s3-bucket"
  bucket_name = "my-demo-bucket-bkt-test"     # Change to a unique bucket name
}
output "instance_id" {
  value = module.ec2.instance_id
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

