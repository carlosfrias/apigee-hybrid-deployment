# Apigee hybrid Deployment Workspace

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/carlosfrias/apigee-hybrid-deployment.git)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://shell.cloud.google.com/cloudshell/editor?cloudshell_image=us-east1-docker.pkg.dev/friasc-apigee-lab/apigee-workspace/apigee-cloudshell-workspace)





    [![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/carlosfrias/apigee-hybrid-deployment.git&cloudshell_tutorial=tutorial.md)


This intent of this project is to create a portable workspace 
from which to deploy an Apigee hybrid instance. This workspace
can be used to quickly deploy a working hybrid instance or to roll
back portions of the build so that configuration changes can be 
tested either in service of a release or to answer a question. 
This project also saves on Argolis billing costs because instead of
maintaining a running instance(s) of hybrid you can maintain configurations
that can be deployed repeatedly to a known state. 




# AWSCLI installer


pip3 install awscli --upgrade
pip3 install boto --upgrade
pip3 install s3transfer --upgrade

aws --version
aws configure

## Install terraform 

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

```