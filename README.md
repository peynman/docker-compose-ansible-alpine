# docker-compose-ansible-alpine
Docker compose &amp; Ansible with plugins required for building docker images inside Ansible tasks

## Usecase
* Gitlab dockerindocker image, used as base image to build docker images using ansible tasks

## Usage
* Inside your gitlab ci file use this image as base image: ``image: peynmannet/docker-compose-ansible-alpine:latest``