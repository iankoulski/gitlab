#!/bin/bash

source .env

{ # try
	echo "Stopping gitlab gracefully ..." &&
	./exec.sh gitlab-ctl stop 
} || { # catch
	echo "Could not stop gitlab gracefully"
}


if [ "${GITLAB_RUNTIME}" == "kubernetes" ]; then
	pushd util
	kubectl delete -f ./gitlab.yaml
	popd
else
	docker container rm -f ${CONTAINER}
fi
