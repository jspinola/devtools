#!/bin/bash

CONTAINER_NAME=$1
if [ "${CONTAINER_NAME}" = "" ]; then
    CONTAINER_NAME="mssql-linux"
fi

MAPPED_PORT=$2
if [ "${MAPPED_PORT}" = "" ]; then
    MAPPED_PORT=5433
fi

docker pull microsoft/mssql-server-linux
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Password12!' -p ${MAPPED_PORT}:1433 --rm --name ${CONTAINER_NAME} -d microsoft/mssql-server-linux