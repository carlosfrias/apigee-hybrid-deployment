#!/bin/bash
pyenv update
pyenv install 3.13.3
pyenv global 3.13.3
pyenv virtualenv 3.13.3 apigee-workspace
pyenv activate apigee-workspace
