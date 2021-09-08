FROM ubuntu:focal

LABEL maintainer="Kirill Plotnikov <init@pltnk.dev>" \
      github="https://github.com/pltnk/docker-liquidsoap"

ENV DEBIAN_FRONTEND=noninteractive

# install liquidsoap dependencies
RUN apt update && apt upgrade -y && \
    apt install -y \
    opam \
    gcc \
    libmad0-dev \
    libmp3lame-dev \
    libogg-dev \
    libpcre3-dev \
    libsamplerate0-dev \
    libtag1-dev \
    libvorbis-dev \
    m4 \
    make \
    pkg-config && \
    apt autoremove && apt clean && \
    rm -rf /var/lib/apt/lists/*

# add user for liquidsoap and create necessary directories
RUN groupadd -g 999 radio && \
    useradd -m -r -u 999 -s /bin/bash -g radio radio && \
    mkdir /etc/liquidsoap /music && \
    chown -R radio /etc/liquidsoap /music

ARG LIQUIDSOAP_VERSION
ARG OPAM_PACKAGES="liquidsoap${LIQUIDSOAP_VERSION:+.$LIQUIDSOAP_VERSION} taglib mad lame vorbis cry samplerate"

USER radio

# setup opam
RUN opam init -a -y --disable-sandboxing && \
    eval $(opam env) && \
    opam install -y depext

# install liquidsoap
RUN opam depext -y ${OPAM_PACKAGES} && \
    opam install -y ${OPAM_PACKAGES} && \
    eval $(opam env) && \
    opam clean -acryv --logs --unused-repositories

CMD eval $(opam env) && liquidsoap /etc/liquidsoap/script.liq
