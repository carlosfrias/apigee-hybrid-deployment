# Usage instructions
# Building this Dockerfile
# docker built -t apigee-workspace-v1 . && docker run -ti apigee-workspace-v1 bash

FROM gcr.io/cloudshell-images/cloudshell:latest AS basic_bootstrap
SHELL ["/bin/bash", "-l", "-c"]

RUN apt-get update -y && apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git software-properties-common curl git mc vim facter aptitude apt-utils apt-transport-https ca-certificates gnupg python3-pip libssl-dev libffi-dev rsync
RUN curl -O --output-dir /tmp https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz \
    && tar -xf /tmp/google-cloud-cli-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh -q \
    && echo 'export PATH="/google-cloud-sdk/bin:$PATH"' >> $HOME/.profile \
    && echo 'export PATH="/google-cloud-sdk/bin:$PATH"' >> $HOME/.bashrc

FROM basic_bootstrap AS gcloud
SHELL ["/bin/bash", "-l", "-c"]
RUN PATH="/google-cloud-sdk/bin:$PATH" gcloud components install kubectl -q \
    && PATH="/google-cloud-sdk/bin:$PATH" gcloud components install gke-gcloud-auth-plugin alpha beta -q


FROM gcloud AS pyenv
# Ensures login shell for RUN, sourcing .profile
SHELL ["/bin/bash", "-l", "-c"]

# Create necessary directories first
RUN mkdir -p /apigee-workspace/apigee-helm/bootstrap

# COPY configure-virtualenv.sh, as it's still needed.
# We no longer copy install-pyenv.sh since its logic is now inlined.
COPY utils/bootstrap/configure-virtualenv.sh /apigee-workspace/apigee-helm/bootstrap/configure-virtualenv.sh

WORKDIR /apigee-workspace/apigee-helm/bootstrap

# Inlined content of install-pyenv.sh:
# 1. Install pyenv dependencies (many might be covered by basic_bootstrap but good to be explicit)
# 2. Clone pyenv repository
# 3. Update .profile and .bashrc for pyenv initialization
# RUN git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv" \
#     && echo '' >> "$HOME/.profile" \
#     && echo '# pyenv configuration' >> "$HOME/.profile" \
#     && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "$HOME/.profile" \
#     && echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> "$HOME/.profile" \
#     && echo 'eval "$(pyenv init -)"' >> "$HOME/.profile" \
#     && echo 'eval "$(pyenv virtualenv-init -)"' >> "$HOME/.profile" \
#     && echo '' >> "$HOME/.bashrc" \
#     && echo '# pyenv configuration' >> "$HOME/.bashrc" \
#     && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "$HOME/.bashrc" \
#     && echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> "$HOME/.bashrc" \
#     && echo 'eval "$(pyenv init -)"' >> "$HOME/.bashrc" \
#     && echo 'eval "$(pyenv virtualenv-init -)"' >> "$HOME/.bashrc" \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*

# Now, run configure-virtualenv.sh in a *new* RUN layer.
# This new layer starts a fresh login shell which will source the updated .profile (and .bashrc),
# making the pyenv command and its shims available to configure-virtualenv.sh.
# RUN bash "configure-virtualenv.sh"

FROM pyenv
SHELL ["/bin/bash", "-l", "-c"]
WORKDIR /apigee-workspace/apigee-helm
COPY molecule /apigee-workspace/apigee-helm/molecule/
COPY resources /apigee-workspace/apigee-helm/resources/
COPY utils /apigee-workspace/apigee-helm/utils/

# The SHELL ["/bin/bash", "-l", "-c"] is inherited.
# This RUN command will execute in a login shell, sourcing .profile,
# which should activate pyenv. However, pyenv has not been available so leaving it off for now.
RUN mkdir -p work_dir \
    && chmod -R +w work_dir \
    && mkdir -p ~/.apigee-secure \
    && cp resources/credentials.yml.template ~/.apigee-secure/credentials.yml \
    && pip install -r /apigee-workspace/apigee-helm/resources/requirements.txt
ENTRYPOINT bash
