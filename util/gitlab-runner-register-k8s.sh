#!/bin/bash

reg_token=$1
if [ -z "${reg_token}" ]; then
        echo ""
        echo "Usage: $0 <registration_token>"
        echo "     registration_token - shared runner token from your GitLab /admin/runners page"
        exit 1
fi

finalize=""
if [ -f ../.env ]; then
        pushd ..
        finalize=popd
fi

source .env

if [ -z "${KUBERNETES_TOKEN}" ]; then
	export KUBERNETES_TOKEN=`kubectl -n gitlab get secret $(kubectl -n gitlab get secret | grep gitlab-sa-token | awk '{print $1}') -o jsonpath="{['data']['token']}" | base64 --decode`
fi

if [ -f "./exec.sh" ]; then
	./exec.sh gitlab-runner register --non-interactive --tls-ca-file="/etc/gitlab/ssl/ssl-gitlab.crt" --tls-cert-file="/etc/gitlab/ssl/ssl-gitlab.crt" --config="/etc/gitlab-runner/config.toml" --registration-token="${reg_token}" --run-untagged="true" --locked="false" --url="${GITLAB_EXTERNAL_URL}/" --executor="kubernetes" --name="shared-kubernetes-runner" --kubernetes-host="https://${HOST_IP}:16443" --kubernetes-ca-file="/etc/gitlab/ssl/ssl-kubernetes.crt" --kubernetes-bearer_token="${KUBERNETES_TOKEN}" --kubernetes-bearer_token_overwrite_allowed="false" --kubernetes-image="docker:git" --kubernetes-namespace="gitlab" --kubernetes-privileged="false" --kubernetes-pull-policy="always" 
	./exec.sh /etc/gitlab-runner/gitlab-runner-config.sh
	./exec.sh service gitlab-runner restart
else
	echo ""
	echo "Could not find exec.sh in current or parent folder"
	echo "Registration aborted"
fi

$finalize
