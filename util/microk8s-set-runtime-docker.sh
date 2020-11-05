#!/bin/bash

set -e

KUBELET_CONFIG_FILE=/var/snap/microk8s/current/args/kubelet

echo ""
echo "Setting kubelet --container-runtime=docker  ..."
cat $KUBELET_CONFIG_FILE | sed -e 's/--container-runtime=remote/--container-runtime=docker/g' | tee /var/snap/microk8s/current/args/kubelet

microk8s.stop
sleep 3
microk8s.start

