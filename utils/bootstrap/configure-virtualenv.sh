#!/bin/bash
source $HOME/.bashrc
export PATH=$HOME/.pyenv:$PATH pyenv update
pyenv install 3.11.2 -s
pyenv global 3.11.2
pyenv virtualenv 3.11.2 apigee-workspace
pyenv activate apigee-workspace
echo "Python environment 'apigee-workspace' is now active for any subsequent commands in this RUN instruction."
python --version
pip --version
pip install -r /apigee-workspace/apigee-helm/resources/requirements.txt
