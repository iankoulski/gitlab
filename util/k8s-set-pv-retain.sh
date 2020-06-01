#!/bin/bash

kubectl -n gitlab patch pv $(kubectl -n gitlab get pvc | grep pvc | awk '{print $3}') -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}'
