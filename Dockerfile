FROM python:3.8-alpine3.13 AS builder

ARG ANSIBLE_VERSION

RUN set -eux \
  && apk add --update --no-cache \
  gcc \
  libc-dev \
  libffi-dev \
  make \
  musl-dev \
  openssl-dev \
  rust \
  cargo && \
  pip install --no-cache-dir \
  ansible==${ANSIBLE_VERSION} \
  ansible-lint \
  molecule \
  molecule-docker \
  jmespath \
  yamllint

FROM python:3.8-alpine3.13

LABEL "maintainer"="Pavel Pikta <pikta.pavel@gmail.com>"

RUN set -eux \
  && apk add --update --no-cache \
  docker \
  git \
  openssh-client \
  && rm -rf /root/.cache

COPY --from=builder /usr/local/lib/python3.8/site-packages/ /usr/local/lib/python3.8/site-packages/
COPY --from=builder /usr/local/bin/molecule /usr/local/bin/molecule
COPY --from=builder /usr/local/bin/yamllint /usr/local/bin/yamllint
COPY --from=builder /usr/local/bin/ansible* /usr/local/bin/

RUN ansible-galaxy collection install community.molecule && \
  ansible --version && \
  ansible-lint --version && \
  molecule --version
