data "aws_availability_zones" "available" {
  state = "available"
  exclude_names = ["ap-south-1-ccu-1a", "ap-south-1-del-1a" ]
}

data "aws_iam_role" "s3-full-access" {
  name = "b90-Allow-S3-Ec2"
}