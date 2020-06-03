#!/bin/bash

source .env

if [ "${GITLAB_RUNTIME}" = "kubernetes" ]; then
	kubectl -n gitlab get all
else
	docker ps -a | grep ${CONTAINER}
fi

echo ""
echo "GITLAB_EXTERNAL_URL=${GITLAB_EXTERNAL_URL}"
echo ""

