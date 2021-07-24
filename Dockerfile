FROM ubuntu:20.04

LABEL "maintainer"="Pavel Pikta <pikta.pavel@gmail.com>"

ENV container=docker \
  LANGUAGE=en_US.UTF-8 \
  LANG=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  TERM=xterm \
  DEBIAN_FRONTEND="noninteractive"

ARG ANSIBLE_VERSION

RUN apt-get update && \
  apt-get install -y \
  build-essential \
  git \
  openssh-client \
  locales \
  libffi-dev \
  libssl-dev \
  libyaml-dev \
  python3 \
  python3-dev \
  python3-setuptools \
  python3-pip \
  python3-yaml && \
  apt-get clean

RUN locale-gen en_US.UTF-8

RUN /usr/bin/python3 -m pip install --no-cache setuptools wheel

RUN /usr/bin/python3 -m pip install --no-cache ansible==${ANSIBLE_VERSION} \
  yamllint \
  ansible-lint \
  molecule \
  molecule-docker

RUN ansible-galaxy collection install community.molecule

RUN apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg && \
  apt-get clean

RUN apt-get install -y docker.io && apt-get clean
