#!/usr/bin/env bash

echo "** creating ecr repo..."
terraform apply -target module.ecr

