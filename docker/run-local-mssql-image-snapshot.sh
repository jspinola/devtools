#!/bin/bash

# Runs a local sql server docker image with default configurations
# Script expects 3 parameters
# sh run-local-mssql-image-snapshot.sh image port container
# image: Name of the docker image to run, by default "microsoft/mssql-server-linux" if not provided
# port: The sql server port to map to the host. By default 5433 if not provided
# container: The name to give to the container. By default "mssql-linux" if not provided

IMAGE_NAME=$1
if ["${IMAGE_NAME}" = ""]; then
    IMAGE_NAME="microsoft/mssql-server-linux"
fi

MAPPED_PORT=$2
if ["${MAPPED_PORT}" = ""]; then
    MAPPED_PORT=5433
fi

CONTAINER_NAME=$3
if ["${CONTAINER_NAME}" = ""]; then
    CONTAINER_NAME="mssql-linux"
fi

docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Password12!' -p ${MAPPED_PORT}:1433 --rm --name ${CONTAINER_NAME} -d ${IMAGE_NAME}