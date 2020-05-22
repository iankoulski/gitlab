#!/bin/bash

subj=$1
if [ -z "$1" ]; then
	subj=localhost
fi	

#openssl req -x509 -newkey rsa:4096 -nodes -subj "/CN=${subj}" -keyout ssl.key -out ssl.crt -days 1095

openssl req -x509 -newkey rsa:4096 -sha256 -days 3560 -nodes -keyout ssl.key -out ssl.crt -subj "/CN=${subj}" -extensions san \
-config <( \
  echo '[req]'; \
  echo 'distinguished_name=req'; \
  echo '[san]'; \
  echo 'subjectAltName=DNS:10.0.2.15,IP:10.0.2.15,DNS:localhost')

