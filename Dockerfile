# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# set version label
ARG BUILD_DATE
ARG VERSION=1
ARG OPENSSH_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

RUN \
  echo "**** install runtime packages ****" && \
  apt update && \
  apt install -y \
  curl \
  logrotate \
  nano \
  netcat-openbsd \
  sudo
RUN \  
  echo "**** install openssh-server ****" && \
  apt install -y \
  openssh-client \
  openssh-server \
  openssh-sftp-server && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** setup openssh environment ****" && \
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
RUN \
  usermod --shell /bin/bash abc && \
  rm -rf \
  /tmp/* \
  $HOME/.cache

# add local files
COPY /root /

EXPOSE 2222

VOLUME /config
