#!/bin/bash

source .env

if [ "$1" == "" ]; then
	CMD="bash"
else
	CMD=$@
fi

if [ "${GITLAB_RUNTIME}" == "kubernetes" ]; then
	kubectl -n gitlab exec -it $(kubectl -n gitlab get pods | grep ${CONTAINER} | grep Running | head -n 1| cut -d ' ' -f 1) -- $CMD
else
	docker container exec -it ${CONTAINER} $CMD 
fi
