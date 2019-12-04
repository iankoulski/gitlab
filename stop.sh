#!/bin/bash

source .env

./exec.sh gitlab-ctl stop
docker container rm -f ${CONTAINER}

