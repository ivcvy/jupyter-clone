#!/bin/bash

# check project name
if [ -z "$1" ]; then
  echo "Error: No project name provided. Please provide a project name."
  echo "Usage: bash start.sh PROJECT_NAME"
  exit 1
fi

PROJECT_NAME=$1

docker start jupyter-clone-${PROJECT_NAME}

# echo the host port number
echo "JupyterLab is running on http://localhost:$(docker port jupyter-clone-$PROJECT_NAME 8888 | grep -o '[0-9]*$')"