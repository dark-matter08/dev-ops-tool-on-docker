FROM python:slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    software-properties-common \
    openssh-client \
    sshpass \
    locales \
    # bat \
    bash \
    git \
    curl \
    rsync \
    zsh \
    nano \
    sudo \
    less \
    # #new
    # gcc \
    # python3-dev \
    # #end-new
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man

ARG USERNAME=ansible
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV HOME=/home/$USERNAME
RUN groupadd --gid $USER_GID $USERNAME
RUN useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL >/etc/sudoers.d/$USERNAME
RUN chmod 0440 /etc/sudoers.d/$USERNAME

RUN pip3 install --no-cache-dir \
    ansible \
    # ansible-cmdb \
    # ansible-runner \
    # ansible-builder \
    # ansible-test \
    ara \
    hvac \
    # molecule \
    dnspython \
    jmespath \
    "hvac[parser]" \
    certifi \
    ansible-lint \
    ansible-modules-hashivault
    # ansible-autodoc

# COPY --from=hashicorp/consul-template /consul-template /usr/local/bin/consul-template
# COPY --from=hashicorp/envconsul /bin/envconsul /usr/local/bin/envconsul
COPY --from=hashicorp/vault /bin/vault  /usr/local/bin/vault
COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker
COPY --from=donaldrich/function:container /usr/local/bin/goss /usr/local/bin/goss
COPY --from=donaldrich/function:task      /usr/local/bin/tusk /usr/local/bin/tusk
COPY --from=donaldrich/function:task      /usr/local/bin/task /usr/local/bin/task
COPY --from=donaldrich/function:task      /usr/local/bin/variant /usr/local/bin/variant
COPY --from=donaldrich/function:syntax-tools /usr/local/bin/jq /usr/local/bin/jq

COPY --from=donaldrich/runner:zsh /zsh/ /zsh/
COPY --from=donaldrich/runner:zsh --chown=ansible:ansible /zsh/.zshrc /home/ansible/.zshrc
COPY --from=donaldrich/runner:zsh --chown=ansible:ansible /zsh/.nanorc /home/ansible/.nanorc

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_FORCE_COLOR true
ENV GOSS_FMT documentation
ENV GOSS_COLOR true

# ENV ANSIBLE_CALLBACK_PLUGINS="$(python3 -m ara.setup.callback_plugins)"
# ENV ARA_API_CLIENT="http"
# ENV ARA_API_SERVER="http://192.168.1.101:8734"

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

COPY ./tusk-docker.yaml ./tusk.yaml
COPY ./goss.yaml ./goss.yaml
COPY ./goss2.yaml ./goss2.yaml
COPY ./Dockerfile ./Dockerfile
COPY ./playbook.yml ./playbook.yml

# USER ${USERNAME}

ENV DEBIAN_FRONTEND=dialog

CMD [ "ansible-playbook", "--version" ]

RUN goss validate
