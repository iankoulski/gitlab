#!/bin/bash

if [ -f .env ]; then
	source .env
elif [ -f ../.env ]; then
	source ../.env
fi

exec_script=./exec.sh
if [ ! -f "${exec_script}" ]; then
	if [ -f "../exec.sh" ]; then
		exec_script=../exec.sh
	else
		echo ""
		echo "Could not find exec.sh in current or parent folder"
		echo "Registration aborted"
		exit 1
	fi
fi

reg_token=$1
if [ -z "${reg_token}" ]; then
	echo ""
	echo "Usage: $0 <registration_token>"
	echo "     registration_token - shared runner token from your GitLab /admin/runners page"
	echo ""
fi

${exec_script} gitlab-runner register --non-interactive --tls-ca-file="/etc/gitlab/ssl/ssl-gitlab.crt" --tls-cert-file="/etc/gitlab/ssl/ssl-gitlab.crt" --config="/etc/gitlab-runner/config.toml" --registration-token="${reg_token}" --run-untagged="true" --locked="false" --url="${GITLAB_EXTERNAL_URL}" --executor="docker" --builds-dir="/var/opt/gitlab-runner/data" --cache-dir="/var/opt/gitlab-runner/cache" --docker-image="docker:git" --docker-privileged="true" --docker-volumes="/etc/docker/certs.d/${GITLAB_REGISTRY_HOSTNAME}:/etc/docker/certs.d/${GITLAB_REGISTRY_HOSTNAME}" --docker-volumes="${GITLAB_RUNNER_PATH_DATA}:/var/opt/gitlab-runner/data" --docker-tlsverify="false" --docker-disable-entrypoint-overwrite="false" --docker-oom-kill-disable="true" --docker-disable-cache="false" --docker-shm-size="0" --name="shared-docker-runner"

