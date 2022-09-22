#!/usr/bin/env fish

# Setup local bin
mkdir -p /home/dev/.local/bin

# Setup workspace
mkdir -p ~/workspace

# Install tfenv/tgenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv

# Clone work repos
cd ~/workspace
git clone git@github.com:plangrid/dacloud-terraform.git
git clone git@github.com:plangrid/dacloud-tf-build-tools.git
git clone git@github.com:plangrid/plangrid-devops.git
git clone git@github.com:plangrid/spinnaker-tools.git
git clone git@github.com:plangrid/onboarding.git

# Setup TF build tools
cd ~/workspace/dacloud-tf-build-tools
sed -i '/^.*brew install.*$/d' Makefile
make setup

# Setup AWS creds tool
cd ~/workspace/onboarding
make get-aws-creds

# Go home
cd

# Install awscli
pip install awscli mssh
