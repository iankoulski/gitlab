#!/bin/bash

kubectl -n gitlab cp ./gitlab-runner-config.sh $(kubectl -n gitlab get pods | grep gitlab | head -n 1 | cut -d ' ' -f 1):/etc/gitlab-runner

