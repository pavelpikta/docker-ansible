ARG IMAGE_VERSION="22.04"

FROM ubuntu:$IMAGE_VERSION

ARG ANSIBLE_CORE_VERSION "2.13.2"
ARG ANSIBLE_VERSION "6.1.0"
ARG ANSIBLE_LINT "6.4.0"
ENV ANSIBLE_CORE_VERSION ${ANSIBLE_CORE_VERSION}
ENV ANSIBLE_VERSION ${ANSIBLE_VERSION}
ENV ANSIBLE_LINT ${ANSIBLE_LINT}

LABEL "maintainer"="Pavel Pikta <pavel_pikta@outlook.com>"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get install -y --no-install-recommends  \
  gnupg2 \
  python3-pip \
  sshpass \
  git \
  openssh-client \
  docker.io && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get autoremove && \
  apt-get clean

RUN python3 -m pip install --no-cache-dir --upgrade pip wheel cryptography cffi && \
  pip3 install --no-cache-dir ansible-core==${ANSIBLE_CORE_VERSION} && \
  pip3 install --no-cache-dir ansible==${ANSIBLE_VERSION} ansible-lint==${ANSIBLE_LINT} yamllint && \
  pip3 install --no-cache-dir molecule molecule-containers molecule-docker molecule-podman molecule-ec2 && \
  rm -rf /root/.cache/pip
