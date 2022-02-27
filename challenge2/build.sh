#!/usr/bin/env bash
docker buildx build --platform linux/amd64 --no-cache -t devops/test:latest . 
