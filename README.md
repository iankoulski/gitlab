# GitLab
An easy to use GitLab container based on the [Depend on Docker](https://github.com/iankoulski/depend-on-docker) project. 

## Basic configuration


    docker container run -d --name gitlab -p 80:80 -p 2222:22 -v gitlab-config:/etc/gitlab gitlab-logs:/var/log/gitlab -v gitlab-data:/var/opt/gitlab iankoulski/gitlab:12.5.2-ce.0


This command will start GitLab and expose its web UI on port 80 and git ssh endpoint on port 2222. All configuration, logs, and data will be stored in named Docker volumes. Only basic features (source control) will be enabled.

## Advanced configuration

More flexibility in configuration can be achieved by cloning the iankoulski/gitlab repo.

    git clone https://github.com/iankoulski/gitlab.git

Modify settings in the .env file per your requirements, then execute the run script to start gitlab.

    ./run.sh

This command will start GitLab with SSL and Docker registry enabled. By default, the UI will be exposed on port 443 and the Docker registry on port 446.

## Initial Login

Once the GitLab instance is fully initialized (see ./logs.sh), you may navigate to GITLAB_EXTERNAL_URL as shown by the ./run.sh or ./status.sh script. If you are running the project locally in docker, you can navigate to http://localhost and you will be redirected automatically.

<p align="center"><img alt="GitLab Initial Login" src="https://github.com/iankoulski/gitlab/raw/master/doc/img/screenshot-gitlab-login1.png" width="90%" align="center"/></p>

You will be asked to create a password. Then you can use user "root" and the password you created to log in for the first time.

## Shared Runner

To enable CI/CD pipelines GitLab requires a runner. This image already comes with a runner service installed locally, however to become operational, the runner needs to be registered with your gitlab instance. A registration token must be provided at registration time.

To register your local runner, navigate to the Admin Area in your GitLab UI, then click on Shared Runners located at the bottom of the Features list. Copy the registration token from the instructions for setting up a shared runner. Then execute the following command:

```console
./util/gitlab-runner-register.sh <registration_token>
```

## Technical details

This container image is based on gitlab/gitlab-ce with one modification. File /opt/gitlab/embedded/cookbooks/postgresql/resources/user.rb is modified to extend the time that the startup script waits for the PostgreSQL database to come online. This avoids startup failures that may occur when the database is recovering from an unexpected shutdown like the one that occurs when the GitLab container restarts. Also, the stop.sh script in the [iankoulski/gitlab](https://github.com/iankoulski/gitlab) project gracefully shuts down the database before removing the container. This resolves [issue 893](https://gitlab.com/gitlab-org/gitlab-foss/issues/893) as reported in the [GitLab Org](https://gitlab.com/gitlab-org) open source repository.

Upon initial startup in the advanced configuration, self-signed SSL certificates are generated for both GitLab and the Docker registry. These certificates are stored in wd/gitlab/config/ssl and can be replaced if needed. To set the location where GitLab configuration, logs, or data is stored, simply edit the provided .env file.

## Deployment to Kubernetes

GitLab can easily be deployed to a Kubernetes cluster by following the steps below:

1) Modify the environment file .env. Set the proper hostnames and paths to the certificates for your GitLab instance. 

2) Generate gitlab.yaml

```console
cd util
./gitlab-yaml-generate.sh
```

3) Apply the generated gitlab.yaml to your cluster

```console
cd util
kubectl apply -f ./gitlab.yaml
```
### Deployment to local Kubernetes cluster

If you are running kubernetes locally, you can run GitLab by following the steps below:

1) Modify the environment file .env by setting the GITLAB_RUNTIME variable to "kubernetes"

2) Execute the run.sh script

3) Optionally, If you would like to register a shared runner after GitLab is up, execute script util/gitlab-runner-register-k8s.sh providing a registration token as argument. The registration token can be copied from the Admin->Runners screen in GitLab.

Note: To push code to a GitLab using self-signed certificates you can use the following command: "git -c http.sslVerify=false push"

## GitLab Community vs Enterprise Edition

This repository contains branches for both the community and enterprise edition of GitLab. The only difference between the two versions of the product is that Enterprise Edition contains functionality which allows you to apply a license and enable the enterprise tier features of GitLab. It is acceptable to operate GitLab Enterprise without an installed license, which is considered the GitLab Free tier a.k.a. GitLab Core. The advantage of defaulting to GitLab Enterprise is that it is possible to apply a license if needed at some point without changing the GitLab deployment. That is why the master branch provides the GitLab Enterprise container. More information on this subject can be found [here](https://about.gitlab.com/install/ce-or-ee/).
