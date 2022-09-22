# Env vars
set -Ux TERM xterm-256color
set -Ux LANG en_US.UTF-8
# Other exports
set -Ux ADSK_USER_NAME callice

# Setup pyenv
set -Ux PYENV_ROOT "$HOME/.pyenv"
fish_add_path -Up $PYENV_ROOT/bin
pyenv init - fish | source
pyenv virtualenv-init - fish | source

# Setup tfenv/tgenv
fish_add_path -Up $HOME/.tfenv/bin
fish_add_path -Up $HOME/.tgenv/bin

# Add /opt/plangrid
fish_add_path -Up /opt/plangrid/

# User bin path (python/etc)
fish_add_path -Up $HOME/.local/bin
