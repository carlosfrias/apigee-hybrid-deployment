# Doesn't work when these instructions are included in the build file and executed with RUN
# Works when the RUN executes this script.

source $HOME/.bashrc
pyenv update
pyenv install 3.13.3
pyenv global 3.13.3
pyenv virtualenv 3.13.3 apigee-workspace
pyenv activate apigee-workspace

