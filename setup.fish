#!/usr/bin/env fish

echo "Setting up git repos in workspace"
mkdir -p ~/workspace
pushd ~/workspace

git clone https://github.com/plangrid/dacloud-terraform
git clone https://github.com/plangrid/dacloud-tf-build-tools
git clone https://github.com/plangrid/plangrid-devops
git clone https://github.com/plangrid/spinnaker-tools
git clone https://github.com/plangrid/onboarding

echo "Installing TF build tools"
cd ~/workspace/dacloud-tf-build-tools
sed -i '/^.*brew install.*$/d' Makefile
make setup

echo "Installing onboarding credential tool"
cd ~/workspace/onboarding
make get-aws-creds

popd
