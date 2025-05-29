#!/bin/bash

git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv"
echo '' >> "$HOME/.profile"
echo '# pyenv configuration' >> "$HOME/.profile"
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "$HOME/.profile"
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> "$HOME/.profile"
echo 'eval "$(pyenv init -)"' >> "$HOME/.profile"
echo '' >> "$HOME/.bashrc"
echo '# pyenv configuration' >> "$HOME/.bashrc"
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "$HOME/.bashrc"
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> "$HOME/.bashrc"
echo 'eval "$(pyenv init -)"' >> "$HOME/.bashrc"
echo 'eval "$(pyenv virtualenv-init -)"' >> "$HOME/.bashrc"
apt-get clean
rm -rf /var/lib/apt/lists/*
