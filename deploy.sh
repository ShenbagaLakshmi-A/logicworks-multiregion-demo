#!/bin/bash

set -e

REGION="ap-south-1"
ACCOUNT_ID="396462617987"
REPO_NAME="logicworks-multiregion-demo"
IMAGE_TAG="1.0"
CONTAINER_NAME="logicworks-demo"

echo "Logging into Amazon ECR"
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

echo "Stopping existing container if running"
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Pulling latest image from ECR"
docker pull $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:$IMAGE_TAG

echo "Starting new container"
docker run -d \
  -p 80:8080 \
  --name $CONTAINER_NAME \
  $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:$IMAGE_TAG

echo "Deployment completed successfully"
