FROM ubuntu:bionic

ENV OCAML_VERSION "4.08.0"
ENV OPAM_PACKAGES "taglib mad lame vorbis cry samplerate liquidsoap"

# install liquidsoap dependencies
RUN apt update && apt upgrade -y && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:avsm/ppa && \
    apt update && \
    apt install -y opam \
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

RUN groupadd -g 999 radio && \
    useradd -m -r -u 999 -s /bin/bash -g radio radio && \
    mkdir /etc/liquidsoap && chown -R radio /etc/liquidsoap && \
    mkdir /music && chown -R radio /music

USER radio

# setup opam
RUN opam init -a -y -c ${OCAML_VERSION} --disable-sandboxing && \
    eval $(opam env) && \
    opam install -y depext

# install liquidsoap
RUN opam depext -y ${OPAM_PACKAGES} && \
    opam install -y ${OPAM_PACKAGES} && \
    eval $(opam env) && opam clean -a

CMD eval $(opam env) && liquidsoap /etc/liquidsoap/script.liq
