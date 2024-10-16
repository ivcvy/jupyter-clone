#!/bin/bash

# check project name
if [ -z "$1" ]; then
  echo "Error: No project name provided. Please provide a project name."
  echo "Usage: bash remove.sh PROJECT_NAME"
  exit 1
fi

PROJECT_NAME=$1

docker stop jupyter-clone-${PROJECT_NAME}
docker rm jupyter-clone-${PROJECT_NAME}
docker volume rm jupyter-clone-${PROJECT_NAME}_db
sed -i '' "/^PROJECT_NAME=$PROJECT_NAME$/d" .env