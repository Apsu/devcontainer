#!/usr/bin/env fish

echo "Setting up git repos in workspace"
mkdir -p ~/workspace
pushd ~/workspace

git clone git@github.com:plangrid/dacloud-terraform.git
git clone git@github.com:plangrid/dacloud-tf-build-tools.git
git clone git@github.com:plangrid/plangrid-devops.git
git clone git@github.com:plangrid/spinnaker-tools.git
git clone git@github.com:plangrid/onboarding.git

echo "Installing TF build tools"
cd ~/workspace/dacloud-tf-build-tools
sed -i '/^.*brew install.*$/d' Makefile
make setup

echo "Installing onboarding credential tool"
cd ~/workspace/onboarding
make get-aws-creds

popd
