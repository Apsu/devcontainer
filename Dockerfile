FROM ubuntu:latest

# Update and install packages
RUN apt update
RUN apt install -y sudo curl git-core openssh-client iputils-ping fish locales \
    python3 build-essential virtualenv \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    libncursesw5-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

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
# Copy login setup script
COPY --chown=dev:dev setup.fish /home/dev/.config/fish/conf.d/

RUN curl https://pyenv.run | bash
RUN fish -c 

# Start shell
CMD ["fish"]