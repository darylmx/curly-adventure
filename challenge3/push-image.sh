#!/usr/bin/env bash

if command -v docker-credential-ecr-login &> /dev/null; then
  has_helper=1
fi

region="ap-southeast-1"

repourl=${1}

if [ "${repourl}" == "" ]; then
  repourl=$(terraform output | grep repository | sed 's#.*"\(.*\)"#\1#')
fi
echo "repo url: ${repourl}"

echo "** tagging devops/test:latest as ${repourl}:1"
echo "> docker tag devops/test:latest ${repourl}:1"
docker tag devops/test:latest ${repourl}:1

myaccount=$(echo $repourl | sed 's#\(.*\)/.*#\1#')
echo "** myaccount: $myaccount"

# auto login to ECR
if [ -z "${has_helper}" ]; then
  echo "> aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${myaccount}"
  aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${myaccount}
else
  echo "** using helper"
fi

echo "> docker push ${repourl}:1"
docker push ${repourl}:1

if [ $? -eq 1 ]; then
    echo "!! error encountered"
    exit 1
else
    echo "** ok. image push successful"
    exit 0
fi
