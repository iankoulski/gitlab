#!/bin/sh

# Container startup script
echo "Container-Root/startup.sh executed"

/assets/wrapper

/opt/gitlab/bin/gitlab-healthcheck --fail --max-time 10

