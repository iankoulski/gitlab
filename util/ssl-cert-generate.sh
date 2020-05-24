#!/bin/bash

if [ -z "${HOST_IP}" ]; then
	if [ -f .fun ]; then
		source .fun
	elif [ -f ../.fun ]; then
		source ../.fun
	fi
fi

if [ "${DEBUG}" == "True" ]; then
	echo "HOST_IP=${HOST_IP}"
fi

subj=$1
if [ -z "$1" ]; then
	subj=localhost
fi	

openssl req -x509 -newkey rsa:4096 -sha256 -days 3560 -nodes -keyout ssl.key -out ssl.crt -subj "/CN=${subj}" -extensions san \
-config <( \
  echo '[req]'; \
  echo 'distinguished_name=req'; \
  echo '[san]'; \
  echo "subjectAltName=DNS:${HOST_IP},IP:${HOST_IP},DNS:localhost")

