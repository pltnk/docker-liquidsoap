# Dockerfile for building liquidsoap from a builder image
ARG BUILDER_NAME
FROM ${BUILDER_NAME} AS ls-builder
FROM ubuntu:resolute
WORKDIR /home/radio

LABEL maintainer="Kirill Plotnikov <init@pltnk.dev>" \
      github="https://github.com/pltnk/docker-liquidsoap"

ENV DEBIAN_FRONTEND=noninteractive
#default is latest

ARG LIQUIDSOAP_VERSION
ARG BUILD_DATE
# install liquidsoap dependencies
RUN apt update && apt upgrade -y && \
    apt install -y \
    # for mad \
    libmad0 \
    # for opus \
    libopus0 \
    # for ffmpeg \
    libavdevice62 \
    libavfilter11 \
    libavcodec62 \
    libavformat62 \
    libavutil60 \
    libswscale9 \
    # for mp3lame \
    libmp3lame0 \
    # for ogg \
    libogg0 \
    libpcre2-8-0 \
    libpcre2-32-0 \
    libpcre2-16-0 \
    libpcre2-posix3 \
    libsamplerate0 \
    libvorbis0a \
    libcurl3t64-gnutls \
    zlib1g && \
    apt autoremove && apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g 999 radio && \
    useradd -m -r -u 999 -s /bin/bash -g radio radio && \
    mkdir /etc/liquidsoap /music && \
    chown -R radio /etc/liquidsoap /music

WORKDIR /home/radio
RUN chown -R radio:radio /home/radio

# .opam has been trimmed in the builder image 
COPY --from=ls-builder --chown=radio:radio /home/radio/.opam/ .opam
USER radio
RUN echo "export PATH=\${HOME}/.opam/default/bin:\${PATH}" >> /home/radio/.bashrc
RUN echo "liquidsoap $LIQUIDSOAP_VERSION build $BUILD_DATE" >> /home/radio/build_tag

CMD bash -c "source .bashrc && liquidsoap /etc/liquidsoap/script.liq"
