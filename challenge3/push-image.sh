#!/usr/bin/env bash

if command -v docker-credential-ecr-login &> /dev/null; then
  has_helper=1
fi

region="ap-southeast-1"

remote_tag=${1}
source_tag=${2:-devops/test:latest}

if [ "${remote_tag}" == "" ]; then
  remote_tag=$(terraform output | grep repository | sed 's#.*"\(.*\)"#\1:1#')
fi
echo "remote_tag: ${remote_tag}"

echo "** tagging ${source_tag} as ${remote_tag}"
echo "> docker tag ${source_tag} ${remote_tag}"
docker tag ${source_tag} ${remote_tag}

myaccount=$(echo ${remote_tag} | sed 's#\(.*\)/.*#\1#')
echo "** myaccount: $myaccount"

# auto login to ECR
if [ -z "${has_helper}" ]; then
  echo "> aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${myaccount}"
  aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${myaccount}
else
  echo "** using helper"
fi

echo "> docker push ${remote_tag}"
docker push ${remote_tag}

if [ $? -eq 1 ]; then
    echo "!! error encountered"
    exit 1
else
    echo "** ok. image push successful"
    exit 0
fi
