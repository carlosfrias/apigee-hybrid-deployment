# Usage instructions
# Building this Dockerfile
# docker built -t apigee-workspace-v1 . && docker run -ti apigee-workspace-v1 bash
#FROM python:3.11.2 AS basic_bootstrap
FROM gcr.io/cloudshell-images/cloudshell:latest AS basic_bootstrap
RUN apt-get update -y \
    && apt-get install software-properties-common curl git mc vim facter aptitude apt-utils apt-transport-https ca-certificates gnupg python3-pip libssl-dev libffi-dev rsync -y
RUN curl -O --output-dir /tmp https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz \
    && tar -xf /tmp/google-cloud-cli-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh -q \
    && echo 'export PATH=/google-cloud-sdk/bin:$PATH' >> $HOME/.bashrc \
    && echo 'export PATH=/google-cloud-sdk/bin:$PATH' >> $HOME/.profile


FROM basic_bootstrap AS gcloud
RUN PATH="/google-cloud-sdk/bin:$PATH" gcloud components install kubectl -q \
    && PATH="/google-cloud-sdk/bin:$PATH" gcloud components install gke-gcloud-auth-plugin alpha beta -q


FROM gcloud AS pyenv
RUN mkdir -p /apigee-workspace/apigee-helm/bootstrap
COPY utils/bootstrap/install-pyenv.sh /apigee-workspace/apigee-helm/bootstrap/install-pyenv.sh
COPY utils/bootstrap/configure-virtualenv.sh /apigee-workspace/apigee-helm/bootstrap/configure-virtualenv.sh
WORKDIR /apigee-workspace/apigee-helm/bootstrap
RUN bash "install-pyenv.sh"
#RUN bash "configure-virtualenv.sh"


FROM pyenv
WORKDIR /apigee-workspace/apigee-helm
COPY molecule /apigee-workspace/apigee-helm/molecule/
COPY resources /apigee-workspace/apigee-helm/resources/
COPY utils /apigee-workspace/apigee-helm/utils/
RUN bash -x /apigee-workspace/apigee-helm/utils/bootstrap/activate-virtualenv-workspace.sh \
    && mkdir -p work_dir \
    && chmod -R +w work_dir \
    && mkdir -p ~/.apigee-secure \
    && cp resources/credentials.yml.template ~/.apigee-secure/credentials.yml
ENTRYPOINT bash
