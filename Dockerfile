FROM docker/compose:alpine-1.29.2

# Metadata params
ARG BUILD_DATE

# Metadata
LABEL maintainer="Peynman. <peynman.net@gmail.com>" \
      org.label-schema.url="https://github.com/peynman/docker-compose-ansible-alpine/blob/master/README.md" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.description="Ansible & terraform on alpine docker dompose image" \
      org.label-schema.schema-version="1.0"

RUN apk --update --no-cache add \
        ca-certificates \
        git \
        openssh-client \
        openssl \
        python3\
        py3-pip \
        py3-cryptography \
        rsync \
        sshpass


RUN apk --update add --virtual \
        .build-deps \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base \
        curl

RUN pip3 install --upgrade --no-cache \
        pip \
        cffi \
        setuptools

RUN pip3 install --no-cache --upgrade \
        ansible \
        ansible-lint

RUN pip3 install --no-cache --upgrade \
        docker-compose

RUN ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip


RUN apk add terraform --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community


RUN apk del \
        .build-deps

RUN rm -rf /var/cache/apk/*
