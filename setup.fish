set -Ux TERM xterm
set -Ux LANG en_US.UTF-8


ssh-agent -c | source
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/id_aws

set -Ux PYENV_ROOT "$HOME/.pyenv"
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
pyenv init - fish | source
pyenv virtualenv-init - fish| source