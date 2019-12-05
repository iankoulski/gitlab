#!/bin/bash

source .env

if [ -z "$1" ]; then
	MODE=-d
else
	MODE=-it
fi

eval docker container run -e GITLAB_OMNIBUS_CONFIG=\"${GITLAB_OMNIBUS_CONFIG}\" ${RUN_OPTS} ${CONTAINER_NAME} ${MODE} ${NETWORK} ${PORT_MAP} ${VOL_MAP} ${REGISTRY}${IMAGE}${TAG} $@

