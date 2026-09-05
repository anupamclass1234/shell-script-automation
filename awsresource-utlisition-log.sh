#!/bin/bash

############################################ Metadata ############################
# This is a script file which shows list of resource utilization
# Author: Anupam Karmakar
# Team: DevOps team
# Date: 28-07-2026 21:00:00 IST
# Script Version: V0.0.1
# Prerequisite: This script is written in bash scripting language, user must be cautious during operation!
# Following are the supported AWS services by the script
# 1. EC2
# 2. S3
# 3. RDS
# 4. DynamoDB
# 5. Lambda
# 6. Cloudfront
# 7. EBS
# 8. ELB
# 9. VPC
# 10. IAM
# 11. EKS
# 12. Cloudformation
# 13. Route53
# Usage: ./aws_resource_list.sh <region> <service_name>
# Example: ./aws_resource_list.sh us-east-1 EC2
#
################################################################################

# Check if the required number of arguments are passed
if [ $# -ne 2 ]; then
  echo "Usage: $0 <region> <service_name>"
  exit 1
fi

REGION=$1
SERVICE=$2

# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
  echo "AWS CLI is not installed, please install AWS CLI and try again"
  exit 1
fi

# Check AWS CLI is configured (a real check, not just the folder existing)
if ! aws sts get-caller-identity &> /dev/null; then
  echo "AWS CLI is not configured correctly, please run 'aws configure' and try again"
  exit 1
fi

# Execute the CLI command based on the service name (case-insensitive)
case "${SERVICE^^}" in
  EC2)
    aws ec2 describe-instances --region "$REGION"
    ;;
  S3)
    aws s3api list-buckets --region "$REGION"
    ;;
  RDS)
    aws rds describe-db-instances --region "$REGION"
    ;;
  EBS)
    aws ec2 describe-volumes --region "$REGION"
    ;;
  *)
    echo "Error: '$SERVICE' is not a supported service, or not yet implemented in this script."
    echo "Supported so far: EC2, S3, RDS, EBS"
    exit 1
    ;;
esac

  


