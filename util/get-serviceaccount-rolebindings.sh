#!/bin/bash

if [ -z "$1" ]; then
	echo ""
	echo "Usage: $0 <SERVICE_ACCOUNT_NAME>"
	echo ""
fi

SERVICE_ACCOUNT_NAME=$1

kubectl get rolebindings,clusterrolebindings \
  --all-namespaces  \
  -o custom-columns='KIND:kind,NAMESPACE:metadata.namespace,NAME:metadata.name,SERVICE_ACCOUNTS:subjects[?(@.kind=="ServiceAccount")].name' | grep "$SERVICE_ACCOUNT_NAME"
