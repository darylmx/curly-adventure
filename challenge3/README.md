# Challenge 3 - Deployment on AWS
## Task
By writing terraform code, create an AWS ECR repository for pushing the Challenge 2 image into. Lastly, create an AWS ECS cluster and spin up a service using the Challenge 2 docker image.

## Prerequisites
- AWS account and credentials configured and set up.
- Docker image from Challenge 2 created in docker registry.

## Instructions
1. Create AWS ECR repository with `terraform init && terraform apply -target module.ecr`.
2. Push docker image from Challenge 2 to AWS ECR repository. Execute `./push-image.sh`.

    By default, this script pushes the local docker image "devops/test:latest" to remote image "{AWS ECR repository created in previous step}:1".
    
    > If error is encountered, please install and configure [amazon-ecr-credential-helper](https://github.com/awslabs/amazon-ecr-credential-helper), then rerun this step.

3. Create AWS ECS cluster with `terraform apply`
4. Test API from Internet. Execute `curl {"test_endpoint" output from previous step}`. A **pong** response is expected.

## Remarks
- The terraform modules required for all challenges are found at the `common modules` folder found at `../modules`.
- The main configuration file for the deployment (for this challenge3) is at `main.tf` of this folder. This file then references the modules (found at `common modules` folder) that is required for this deployment.
- For this exercise, the variables that have been parameterized for the respective modules are limited. This list of variables can be further expanded where and when required.
- The AWS ECS cluster uses Fargate technology to provide on-demand, right-sized compute capacity for the containers.
