#!/usr/bin/env fish

push
echo "Setting up git repos in workspace"
mkdir -p ~/workspace
cd ~/workspace

git clone git@github.com:plangrid/dacloud-terraform.git
git clone git@github.com:plangrid/dacloud-tf-build-tools.git
git clone git@github.com:plangrid/plangrid-devops.git
git clone git@github.com:plangrid/spinnaker-tools.git
git clone git@github.com:plangrid/onboarding.git

cd ~/workspace/dacloud-tf-build-tools
sed -i '/^.*brew install.*$/d' Makefile
make setup

cd ~/workspace/onboarding
make get-aws-creds

pop