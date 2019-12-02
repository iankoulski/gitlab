#!/bin/bash

subj=$1
if [ -z "$1" ]; then
	subj=localhost
fi	

openssl req -x509 -newkey rsa:4096 -nodes -subj "/CN=${subj}" -keyout ssl.key -out ssl.crt -days 1095

