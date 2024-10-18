#!/bin/bash

# check project name
if [ -z "$1" ]; then
  echo "Error: No project name provided. Please provide a project name."
  echo "Usage: bash remove.sh PROJECT_NAME"
  exit 1
fi

PROJECT_NAME=$1

# find project and port in .env
if [ -f .env ] && grep -q "PROJECT_NAME=$PROJECT_NAME" .env; then
  PROJECT_PORT=$(awk -v project="PROJECT_NAME=$PROJECT_NAME" '$0 == project {getline; print}' .env | grep -o '[0-9]*$')
else
  echo "Error: Project name '$PROJECT_NAME' not found in .env."
  exit 1
fi

# Get container ID by name
CONTAINER_ID=$(docker ps -aqf "name=jupyter-clone-${PROJECT_NAME}")

docker stop $CONTAINER_ID
docker rm $CONTAINER_ID
docker rmi -f jupyter-clone-${PROJECT_NAME}-jupyter:latest
sed -i '' "/^PROJECT_NAME=$PROJECT_NAME$/d" .env
sed -i '' "/^PROJECT_PORT=$PROJECT_PORT$/d" .env