#!/bin/bash

server=$1
port=$2
if [ -z "$1" ]; then
	echo "Usage: $0 <server> [port]"
else
	if [ -z "$2" ]; then
		port=443
	fi
	echo | openssl s_client -connect ${server}:${port} 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
fi	

