#!/bin/bash

chown -R -v git:root /var/opt/gitlab/git-data                           \
&& chmod -R -v 0700 /var/opt/gitlab/git-data                            \
&& chown -R -v git:git /var/opt/gitlab/git-data/repositories            \
&& chmod -R -v 2770 /var/opt/gitlab/git-data/repositories               \
&& chown -R -v git:gitlab-www /var/opt/gitlab/gitlab-rails/shared       \
&& chmod -R -v 0751 /var/opt/gitlab/gitlab-rails/shared                 \
&& chown -R -v git:root /var/opt/gitlab/gitlab-rails/shared/artifacts   \
&& chmod -R -v 0700 /var/opt/gitlab/gitlab-rails/shared/artifacts       \
&& chown -R -v git:root /var/opt/gitlab/gitlab-rails/shared/lfs-objects \
&& chmod -R -v 0700 /var/opt/gitlab/gitlab-rails/shared/lfs-objects     \
&& chown -R -v git:root /var/opt/gitlab/gitlab-rails/uploads            \
&& chmod -R -v 0700 /var/opt/gitlab/gitlab-rails/uploads                \
&& chown -R -v git:gitlab-www /var/opt/gitlab/gitlab-rails/shared/pages \
&& chmod -R -v 0750 /var/opt/gitlab/gitlab-rails/shared/pages           \
&& chown -R -v git:root /var/opt/gitlab/gitlab-ci/builds                \
&& chmod -R -v 0700 /var/opt/gitlab/gitlab-ci/builds                    \
&& chown -R -v gitlab-psql:git /var/opt/gitlab/postgresql/data          \
&& chmod -R -v 0700  /var/opt/gitlab/postgresql/data                    \
&& gitlab-ctl reconfigure                                               \
&& gitlab-rake gitlab:check                                             \
&& gitlab-ctl restart
