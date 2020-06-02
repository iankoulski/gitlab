#!/bin/bash

source .env

if [ "${GITLAB_RUNTIME}" == "kubernetes" ]; then
	kubectl -n gitlab logs -f $(kubectl -n gitlab get pods | grep ${CONTAINER} | head -n 1 | cut -d ' ' -f 1) 
else
	docker container logs -f ${CONTAINER}
fi
