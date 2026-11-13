#Dockerfile for compiling liquidsoap from opam
FROM ubuntu:resolute

LABEL maintainer="Kirill Plotnikov <init@pltnk.dev>" \
      github="https://github.com/pltnk/docker-liquidsoap"

ENV DEBIAN_FRONTEND=noninteractive
#default is latest
ARG LIQUIDSOAP_VERSION
# by default we are not building video options 
# https://github.com/savonet/liquidsoap/blob/main/dune-project has optional dependencies
ARG PLUGINS="yaml mad lame ogg vorbis opus cry samplerate inotify ffmpeg "
ARG OPAM_PACKAGES="liquidsoap${LIQUIDSOAP_VERSION:+.$LIQUIDSOAP_VERSION} ${PLUGINS}"

# install liquidsoap dependencies
RUN apt update && apt upgrade -y && \
    apt install -y \
    build-essential \
    curl \
    opam \
    gcc \
    cmake \
    # for mad \
    libmad0-dev \
    # for opus \
    libopus-dev \
    # for ffmpeg \
    libavdevice-dev \
    libavfilter-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    # for mp3lame \
    libmp3lame-dev \
    # for ogg \
    libogg-dev \
    libpcre2-dev \
    libsamplerate0-dev \
    libvorbis-dev \
    m4 \
    make \
    pkg-config \
    libcurl4-gnutls-dev \
    zlib1g-dev && \
    apt autoremove && apt clean && \
    rm -rf /var/lib/apt/lists/*

# disabled, for adding custom libtag-1.13.1
#RUN dpkg -i /pkg/libtag1v5_1.13.1-1build1_amd64.deb /pkg/libtag1-dev_1.13.1-1build1_amd64.deb /pkg/libtag1v5-vanilla_1.13.1-1build1_amd64.deb
# add user for liquidsoap and create necessary directories
RUN groupadd -g 999 radio && \
    useradd -m -r -u 999 -s /bin/bash -g radio radio && \
    mkdir /etc/liquidsoap /music && \
    chown -R radio /etc/liquidsoap /music

USER radio

RUN opam init -a -y --disable-sandboxing 
RUN opam install -y ${OPAM_PACKAGES} && \
    eval $(opam env) && \
    opam clean -acryv --logs --unused-repositories

# prune out what isn't needed for running liquidsoap.
COPY scripts/prune_opam.sh /
RUN bash /prune_opam.sh

CMD /bin/bash
# install liquidsoap
