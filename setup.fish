#!/usr/bin/env fish

# Install pyenv
curl https://pyenv.run | bash
# Setup pyenv
set -Ux PYENV_ROOT "$HOME/.pyenv"
fish_add_path -Up $PYENV_ROOT/bin
pyenv init - fish | source
pyenv virtualenv-init - fish | source
# Install python 3.9.4
pyenv install 3.9.4

# Install tfenv/tgenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv

# Install awscli
pip install awscli mssh

# Setup local bin
mkdir -p /home/dev/.local/bin

# Setup workspace
mkdir -p ~/workspace
cd ~/workspace

# Clone work repos
git clone https://github.com/plangrid/dacloud-terraform
git clone https://github.com/plangrid/dacloud-tf-build-tools
git clone https://github.com/plangrid/plangrid-devops
git clone https://github.com/plangrid/spinnaker-tools
git clone https://github.com/plangrid/onboarding

# Setup TF build tools
cd ~/workspace/dacloud-tf-build-tools
sed -i '/^.*brew install.*$/d' Makefile
make setup

# Setup AWS creds tool
cd ~/workspace/onboarding
make get-aws-creds
