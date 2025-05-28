# Doesn't work when these instructions are included in the build file and executed with RUN
# Works when the RUN executes this script.

echo 'Installing pyenv'

curl -fsSL https://pyenv.run | bash
echo 'export PYENV_ROOT=$HOME/.pyenv' >> $HOME/.bashrc
echo 'export PYENV_ROOT=$HOME/.pyenv' >> $HOME/.profile
echo 'export PATH=$PYENV_ROOT/bin:$PATH' >> $HOME/.bashrc
echo 'export PATH=$PYENV_ROOT/bin:$PATH' >> $HOME/.profile
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init - bash)"' >> $HOME/.bashrc
echo 'eval "$(pyenv init - bash)"' >> $HOME/.profile
echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.profile
source $HOME/.bashrc
