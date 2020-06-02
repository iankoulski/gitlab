#!/bin/bash

source .env

./exec.sh gitlab-ctl stop
if [ "${GITLAB_RUNTIME}" == "kubernetes" ]; then
	pushd util
	kubectl delete -f ./gitlab.yaml
	popd
else
	docker container rm -f ${CONTAINER}
fi
