## docker-liquidsoap

[![Build Status](https://img.shields.io/github/workflow/status/pltnk/docker-liquidsoap/Build%20and%20publish%20Docker%20image)](https://github.com/pltnk/docker-liquidsoap/actions/workflows/docker-publish.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/pltnk/liquidsoap)](https://hub.docker.com/r/pltnk/liquidsoap)
[![Docker Image Size](https://img.shields.io/docker/image-size/pltnk/liquidsoap/latest)](https://hub.docker.com/r/pltnk/liquidsoap)
[![License](https://img.shields.io/github/license/pltnk/docker-liquidsoap)](https://github.com/pltnk/docker-liquidsoap/blob/master/LICENSE)

Dockerfile for running [Liquidsoap](https://www.liquidsoap.info/) in a container. \
Just mount your Liquidsoap script, music directory and you are good to go!

Works well with containerized [icecast2](https://icecast.org/): [pltnk/docker-icecast2](https://github.com/pltnk/docker-icecast2)

### Installation
- Pull the image from one of public Docker registries, supported tags: `1.4.4`, `2.0.0`, `latest`
  - Docker Hub `docker pull pltnk/liquidsoap`
  - GitHub Packages `docker pull ghcr.io/pltnk/liquidsoap`
  - Quay.io `docker pull quay.io/pltnk/liquidsoap`
- Build the image yourself
  - `docker build -t pltnk/liquidsoap github.com/pltnk/docker-liquidsoap`
  - Add build arg `LIQUIDSOAP_VERSION` to specify the version of Liquidsoap to use in the image, check available versions [here](https://opam.ocaml.org/packages/liquidsoap/). \
  Example: `docker build -t pltnk/liquidsoap:1.4.4 --build-arg LIQUIDSOAP_VERSION=1.4.4 github.com/pltnk/docker-liquidsoap`

### Configuration
- Mount your Liquidsoap script file to `/etc/liquidsoap/script.liq`
- Mount your music directory to `/music`
- In your Liquidsoap script change path to your music directory to `/music`

#### docker run
```
docker run --name liquidsoap -d --restart=always \
--volume /path/to/your/script.liq:/etc/liquidsoap/script.liq \
--volume /path/to/your/music:/music \
pltnk/liquidsoap
```
#### docker-compose.yml
```
liquidsoap:
  image: pltnk/liquidsoap
  container_name: liquidsoap
  restart: always
  volumes:
    - /path/to/your/script.liq:/etc/liquidsoap/script.liq
    - /path/to/your/music:/music
```
