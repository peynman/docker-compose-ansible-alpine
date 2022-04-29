FROM docker:20.10.14-alpine3.15

# Metadata params
ARG BUILD_DATE


RUN apk add --no-cache py3-pip python3-dev libffi-dev openssl-dev curl gcc libc-dev rust cargo make && \
    pip3 install --no-cache-dir docker-compose==1.29.2


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
        sshpass \
        jq


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


COPY gitlab-terraform.sh /usr/bin/gitlab-terraform
RUN chmod +x /usr/bin/gitlab-terraform