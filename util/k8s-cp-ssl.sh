#!/bin/bash

kubectl -n gitlab get secret $(kubectl -n gitlab get secret | grep gitlab-sa-token | awk '{print $1}') -o jsonpath="{['data']['ca\.crt']}" | base64 --decode > ../wd/gitlab/config/ssl/ssl-kubernetes.crt

kubectl -n gitlab cp ../wd/gitlab/config/ssl $(kubectl -n gitlab get pods | grep gitlab | head -n 1 | cut -d ' ' -f 1):/etc/gitlab

