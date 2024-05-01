#!/bin/bash

# Stop the Docker container
docker stop modu-api

# Stop the Docker container
docker stop modu-client

# Remove the Docker container
docker rm modu-api

# Remove the Docker container
docker rm modu-client


# Remove the Docker image
docker image rm everything_in_one_modu-api
# Remove the Docker image
docker image rm everything_in_one_modu-client