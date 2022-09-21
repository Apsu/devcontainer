FROM ubuntu:latest

# Update and install packages
RUN apt update
RUN apt install -y sudo curl git-core openssh-client iputils-ping \
    fish locales btop tmux vim jq lsb-release gnupg \
    python3 build-essential virtualenv pre-commit unzip \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    libncursesw5-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Link "python" to "python3"
RUN update-alternatives install /usr/bin/python python /usr/bin/python3 1

# Add vault repo and install
RUN curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt install vault

# Create user and setup sudo access
RUN adduser --disabled-password --shell /bin/fish --gecos 'Dev User' dev
RUN adduser dev sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/passwordless

# Generate locales
RUN locale-gen en_US.UTF-8

# Setup image user/env
USER dev
WORKDIR /home/dev
# Create config files
RUN fish -c exit
# Copy user script
COPY --chown=dev:dev user.fish /home/dev/.config/fish/conf.d/
# Copy setup script
COPY --chown=dev:dev setup.fish /home/dev/

# Install pyenv
RUN curl https://pyenv.run | bash
# Install python 3.9.4
# RUN fish -c "pyenv install 3.9.4"
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv
RUN git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv

# Start shell
CMD ["fish"]