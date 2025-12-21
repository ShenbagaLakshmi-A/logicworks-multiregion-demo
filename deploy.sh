#!/bin/bash
set -e

echo "Preparing SSH key"
mkdir -p ~/.ssh
echo "$EC2_SSH_KEY" > ~/.ssh/ec2-key.pem
chmod 400 ~/.ssh/ec2-key.pem

echo "Deploying to EC2"
ssh -o StrictHostKeyChecking=no -i ~/.ssh/ec2-key.pem \
$EC2_USER@$EC2_HOST << EOF

docker stop logicworks-demo || true
docker rm logicworks-demo || true

aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

docker pull $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:1.0

docker run -d -p 80:8080 --name logicworks-demo \
$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:1.0

EOF
