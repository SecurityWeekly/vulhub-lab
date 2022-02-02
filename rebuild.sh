#!/bin/bash

if [ "$#" -eq 1 ]
then
  echo "Stopping Running Container: $1"
  docker stop $1
  echo "Removing Container Image: vulhub-lab_$1"
  docker rmi -f "vulhub-lab_$1"
  echo "Stopping All Services"
  docker-compose down
  echo "Bring up all services"
  docker-compose up -d
else
  echo "Bring all services down and removing all images"
  docker-compose down --rmi all --remove-orphans
  echo "Building all containers"
  docker-compose build --force-rm --no-cache --parallel
  echo "Bring up all services"
  docker-compose up -d
fi
