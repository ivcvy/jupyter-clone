#!/bin/bash

# check project name
if [ -z "$1" ]; then
  echo "Error: No project name provided. Please provide a project name."
  echo "Usage: bash build.sh PROJECT_NAME"
  exit 1
fi

PROJECT_NAME=$1

if [ -f .env ] && grep -q "PROJECT_NAME=$PROJECT_NAME" .env; then
  echo "Error: Project name '$PROJECT_NAME' already exists in .env."
  exit 1
fi

# add user
echo "UID=$(id -u)" > .env
echo "GID=$(id -g)" >> .env

# keep env as project log
if [ -f .env ]; then
  echo "PROJECT_NAME=$PROJECT_NAME" >> .env
else
  echo "PROJECT_NAME=$PROJECT_NAME" > .env
fi

docker network create jupyter-clone 2> /dev/null
mkdir -p db/$PROJECT_NAME
docker compose up --build -d

PROJECT_PORT=$(docker port jupyter-clone-$PROJECT_NAME 8888 | grep -o '[0-9]*$')

# keep port for start.sh
if [ -f .env ]; then
  echo "PROJECT_PORT=$PROJECT_PORT" >> .env
fi

# echo the host port number
echo "JupyterLab is running on http://localhost:$PROJECT_PORT"