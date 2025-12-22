#!/bin/bash
set -e

aws ecr get-login-password --region ap-south-1 \
 | docker login --username AWS --password-stdin 396462617987.dkr.ecr.ap-south-1.amazonaws.com

docker pull 396462617987.dkr.ecr.ap-south-1.amazonaws.com/logicworks-multiregion-demo:1.0

docker stop logicworks-demo || true
docker rm logicworks-demo || true

docker run -d -p 80:8080 --name logicworks-demo \
396462617987.dkr.ecr.ap-south-1.amazonaws.com/logicworks-multiregion-demo:1.0
