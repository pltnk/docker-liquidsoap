FROM debian:bookworm-slim

LABEL maintainer="Kirill Plotnikov <init@pltnk.dev>" \
      github="https://github.com/pltnk/docker-liquidsoap"

ENV DEBIAN_FRONTEND=noninteractive

# install liquidsoap dependencies
RUN apt update && apt upgrade -y && \
    apt install -y \
    opam \
    gcc \
    libavcodec-dev \
    libavdevice-dev \
    libavfilter-dev \
    libavformat-dev \
    libavutil-dev \
    libjemalloc-dev \
    libswresample-dev \
    libswscale-dev \
    libcurl4-gnutls-dev \
    libmad0-dev \
    libmp3lame-dev \
    libogg-dev \
    libpcre3-dev \
    libsamplerate0-dev \
    libssl-dev \
    libtag1-dev \
    libvorbis-dev \
    m4 \
    make \
    pkg-config \
    zlib1g-dev && \
    apt autoremove && apt clean && \
    rm -rf /var/lib/apt/lists/*

ARG LIQUIDSOAP_VERSION
ARG OPAM_PACKAGES="liquidsoap${LIQUIDSOAP_VERSION:+.$LIQUIDSOAP_VERSION} taglib mad lame vorbis cry samplerate ssl ffmpeg jemalloc"

# add user for liquidsoap and create necessary directories
RUN groupadd -g 999 radio && \
    useradd -m -r -u 999 -s /bin/bash -g radio radio && \
    mkdir /etc/liquidsoap /music && \
    chown -R radio /etc/liquidsoap /music

USER radio

# setup opam
RUN opam init -a -y --disable-sandboxing --comp 4.14.2

# install liquidsoap
RUN opam install -y ${OPAM_PACKAGES} && \
    eval $(opam env) && \
    opam clean -acryv --logs --unused-repositories

CMD eval $(opam env) && liquidsoap /etc/liquidsoap/script.liq
