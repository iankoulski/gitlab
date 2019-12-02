#!/bin/bash

source .env

docker stop ${CONTAINER}
docker container rm -f ${CONTAINER}

