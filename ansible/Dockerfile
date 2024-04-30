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

ARG USERNAME=ansible
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV HOME=/home/$USERNAME

# Create ansible user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL >/etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

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

# Default command
CMD [ "ansible-playbook", "--version" ]
CMD [ "ansible-playbook", "playbook.yml" ]
CMD ["tail", "-f", "/dev/null"]





