FROM ubuntu:latest

# Update and install packages
RUN apt update
RUN apt install -y sudo curl git-core openssh-client iputils-ping \
    fish locales btop tmux vim jq lsb-release gnupg \
    python3 build-essential virtualenv pre-commit unzip \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    libncursesw5-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Link "python" to "python3"
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install vault binary
RUN curl -O https://releases.hashicorp.com/vault/1.11.3/vault_1.11.3_linux_amd64.zip && \
    unzip vault_1.11.3_linux_amd64.zip && mv vault /usr/bin/ && rm vault_1.11.3_linux_amd64.zip

# Create user and setup sudo access
RUN adduser --disabled-password --shell /bin/fish --gecos 'Dev User' dev
RUN adduser dev sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/passwordless

# Generate locales
RUN locale-gen en_US.UTF-8

# Create and own opt
RUN mkdir -p /opt/plangrid && chown -R dev /opt

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

# Install awscli
RUN pip install awscli mssh

# Setup local bin
RUN mkdir -p /home/dev/.local/bin

# Start shell
CMD ["fish"]