ARG IMAGE="alpine:3.16"

FROM $IMAGE

ARG ANSIBLE_CORE_VERSION "2.13.2"
ARG ANSIBLE_VERSION "6.1.0"
ARG ANSIBLE_LINT "6.3.0"
ENV ANSIBLE_CORE_VERSION ${ANSIBLE_CORE_VERSION}
ENV ANSIBLE_VERSION ${ANSIBLE_VERSION}
ENV ANSIBLE_LINT ${ANSIBLE_LINT}

LABEL "maintainer"="Pavel Pikta <pavel_pikta@outlook.com>"

RUN apk --no-cache add \
  sudo \
  python3\
  py3-pip \
  openssl \
  ca-certificates \
  sshpass \
  openssh-client \
  rsync \
  git \
  docker && \
  apk --no-cache add --virtual build-dependencies \
  python3-dev \
  libffi-dev \
  musl-dev \
  gcc \
  cargo \
  openssl-dev \
  libressl-dev \
  build-base && \
  pip3 install --upgrade pip wheel && \
  pip3 install --upgrade cryptography cffi && \
  pip3 install ansible-core==${ANSIBLE_CORE_VERSION} && \
  pip3 install ansible==${ANSIBLE_VERSION} ansible-lint==${ANSIBLE_LINT} yamllint && \
  pip3 install molecule molecule-containers molecule-docker molecule-podman molecule-ec2 && \
  apk del build-dependencies && \
  rm -rf /var/cache/apk/* && \
  rm -rf /root/.cache/pip && \
  rm -rf /root/.cargo
