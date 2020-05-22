#!/bin/sh

# Container startup script
echo "Container-Root/startup.sh executed"

echo GITLAB_BACKUP_CRONTAB_LINE="${GITLAB_BACKUP_CRONTAB_LINE}"

echo ${GITLAB_BACKUP_CRONTAB_LINE} | sed -e 's/\\//g' >> /etc/crontab

service cron start

service gitlab-runner start

/opt/gitlab/bin/gitlab-healthcheck --fail --max-time 10 &

/assets/wrapper

