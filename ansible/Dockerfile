FROM python:slim

ENV DEBIAN_FRONTEND noninteractive

# Install necessary packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    software-properties-common \
    openssh-client \
    sshpass \
    locales \
    bash \
    git \
    curl \
    rsync \
    zsh \
    nano \
    sudo \
    less \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man

ARG USERNAME=ansadmin
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV HOME=/home/$USERNAME

# Create ansible user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL >/etc/sudoers.d/$USERNAME \
    && echo "$USERNAME ALL=(ALL:ALL) NOPASSWD:ALL" >/etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# RUN groupadd --gid $USER_GID $USERNAME \
#     && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
#     && echo "$USERNAME ALL=(ALL:ALL) NOPASSWD:ALL" >/etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME

# Install Ansible and dependencies
RUN pip3 install --no-cache-dir \
    ansible \
    ara \
    hvac \
    dnspython \
    jmespath \
    "hvac[parser]" \
    certifi \
    ansible-lint \
    ansible-modules-hashivault


# Install Docker CLI
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh


# Install buildx component
RUN mkdir -p ~/.docker/cli-plugins \
    && curl -SL https://github.com/docker/buildx/releases/download/v0.5.1/buildx-v0.5.1.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx \
    && chmod a+x ~/.docker/cli-plugins/docker-buildx

# Set environment variables
ENV ANSIBLE_HOST_KEY_CHECKING=false
ENV ANSIBLE_FORCE_COLOR=true

# Set locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
    && locale-gen en_US.UTF-8

# Set the working directory
# WORKDIR $HOME

RUN ssh-agent bash

RUN sudo chmod -R 777 /home/ansadmin

RUN mkdir /home/ansadmin/.ssh

RUN usermod -aG docker ansadmin

# USER ansadmin
# Default command
CMD [ "ansible-playbook", "--version" ]
CMD [ "ansible-playbook", "playbook.yml" ]
CMD ["tail", "-f", "/dev/null"]





