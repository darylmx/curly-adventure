# Challenge 2 - Containerisation
## Task
Create a `Dockerfile` in the root directory according to any best practices you may know about.

## Prerequisites
- Docker environment
  
## Instructions
- Build container image. Execute `./build.sh`.

  This script executes `docker buildx build --platform linux/amd64 -t devops/webapp:latest .`

  This is to standardize the resultant container image that could be built from different platforms.

- Verify container image is successfuly created in local docker registry. Execute
        `docker image ls devops/webapp:latest`

    > Container image entry should be listed in output