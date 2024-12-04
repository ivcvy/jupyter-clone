#!/bin/bash

# check project name
if [ -z "$1" ]; then
  echo "Error: No project name provided. Please provide a project name."
  echo "Usage: bash start.sh PROJECT_NAME"
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

docker run -d -p $PROJECT_PORT:8888 --user $(id -u):$(id -g) --name jupyter-clone-${PROJECT_NAME} --mount type=bind,src="./db/${PROJECT_NAME}",target=/home/jovyan/ jupyter-clone-${PROJECT_NAME}_jupyter start-notebook.sh --NotebookApp.token=''

# echo the host port number
echo "JupyterLab is running on http://localhost:$(docker port jupyter-clone-$PROJECT_NAME 8888 | grep -o '[0-9]*$')"