## docker-liquidsoap

[![Build Status](https://img.shields.io/github/actions/workflow/status/pltnk/docker-liquidsoap/docker-publish.yml?branch=main)](https://github.com/pltnk/docker-liquidsoap/actions/workflows/docker-publish.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/pltnk/liquidsoap)](https://hub.docker.com/r/pltnk/liquidsoap)
[![Docker Image Size](https://img.shields.io/docker/image-size/pltnk/liquidsoap/latest)](https://hub.docker.com/r/pltnk/liquidsoap)
[![License](https://img.shields.io/github/license/pltnk/docker-liquidsoap)](https://github.com/pltnk/docker-liquidsoap/blob/master/LICENSE)

Dockerfile for running [Liquidsoap](https://www.liquidsoap.info/) in a container. \
Just mount your Liquidsoap script, music directory and you are good to go!

Works well with containerized [icecast2](https://icecast.org/): [pltnk/docker-icecast2](https://github.com/pltnk/docker-icecast2)

### Installation
- Pull the image from one of public Docker registries, supported tags: `2.4.6`, `latest`
  - Docker Hub `docker pull drewaogle/liquidsoap`
- Build the image yourself
  - `bash build.sh`
  - To Specify a version:
    ` LIQUIDSOAP_VERSION=2.5.0 bash build.sh` - to specify the version of Liquidsoap to use in the image, check available versions [here](https://opam.ocaml.org/packages/liquidsoap/). 
    Note that this build use ffmpeg by default which may not exist in older version. I have put a dockerfile in the taglib directory to create the required taglib version
      in ubuntu resolute.

### Configuration
- Mount your Liquidsoap script file to `/etc/liquidsoap/script.liq`
- Mount your music directory to `/music`
- In your Liquidsoap script change path to your music directory to `/music`

#### docker run
```
docker run --name liquidsoap -d --restart=always \
--volume /path/to/your/script.liq:/etc/liquidsoap/script.liq \
--volume /path/to/your/music:/music \
drewaogle/liquidsoap:2.4.6
```
#### docker-compose.yml
```
liquidsoap:
  image: drewaogle/liquidsoap:2.4.6
  container_name: liquidsoap
  restart: always
  volumes:
    - /path/to/your/script.liq:/etc/liquidsoap/script.liq
    - /path/to/your/music:/music
```
