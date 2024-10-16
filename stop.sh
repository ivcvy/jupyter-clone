#!/bin/bash

# check project name
if [ -z "$1" ]; then
  echo "Error: No project name provided. Please provide a project name."
  echo "Usage: bash stop.sh PROJECT_NAME"
  exit 1
fi

PROJECT_NAME=$1

docker stop jupyter-clone-${PROJECT_NAME}