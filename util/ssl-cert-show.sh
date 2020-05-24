#!/bin/bash

cert=$1
if [ -z "$1" ]; then
	cert=ssl.crt
fi	

openssl x509 -in ${cert} -text -noout

