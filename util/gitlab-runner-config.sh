#!/bin/bash

cat << EOF >> /etc/gitlab-runner/config.toml
      [[runners.kubernetes.volumes.host_path]]
        name = "docker-socket"
	host_path = "/var/run/docker.sock"
	mount_path = "/var/run/docker.sock"
	read_only = false
EOF

