# GitLab
An easy to operate GitLab container as a [Depend on Docker](https://github.com/iankoulski/depend-on-docker) project

## Basic configuration


    docker container run -d --name gitlab -p 80:80 -p 2222:22 -v gitlab-config:/etc/gitlab gitlab-logs:/var/log/gitlab -v gitlab-data:/var/opt/gitlab iankoulski/gitlab:12.5.2-ce.0


This command will start gitlab and expose its web UI on port 80. All configuration, logs, and data will be stored in named Docker volumes. Only basic features (source control) will be enabled.

## Advanced configuration

More flexibility in configuration can be achieved by cloning the iankoulski/gitlab repo.

    git clone https://github.com/iankoulski/gitlab.git

Modify settings in the .env file per your requirements, then execute the run script to start gitlab.


    ./run.sh



