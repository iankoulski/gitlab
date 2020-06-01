#!/bin/bash

source .env

if [ -z "$1" ]; then
	MODE=-d
else
	MODE=-it
fi

if [ "${GITLAB_RUNTIME}" == "kubernetes" ]; then
	pushd util
	echo "Applying gitlab.yaml ..."
	./gitlab-yaml-generate.sh
	kubectl apply -f ./gitlab.yaml
	while [ ! "$(kubectl -n gitlab get pods | grep gitlab | head -n 1 | awk '{print $3}')" == "Running" ]; do
		echo "Waiting for gitlab pod to enter Running state ..."
	        sleep 5
	done;
	echo "Copying ssl certs and scripts to PV ..."
	./k8s-cp-ssl.sh
	./k8s-cp-sh.sh
	echo "Done."
	popd
else
	eval docker container run -e GITLAB_OMNIBUS_CONFIG=\"${GITLAB_OMNIBUS_CONFIG}\" ${RUN_OPTS} ${CONTAINER_NAME} ${MODE} ${NETWORK} ${PORT_MAP} ${VOL_MAP} ${REGISTRY}${IMAGE}${TAG} $@
fi
