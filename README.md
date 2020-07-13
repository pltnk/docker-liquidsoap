## docker-liquidsoap
Dockerfile for running [Liquidsoap](https://www.liquidsoap.info/) in a container. \
Just mount your Liquidsoap script, music directory and you are good to go!

### Installation:
You can either pull the image from Dockerhub \
`docker pull pltnk/liquidsoap` \
or build it yourself \
`docker build -t pltnk/liquidsoap github.com/pltnk/docker-liquidsoap`

### Configuration:
- Mount your Liquidsoap script file to `/radio/script.liq`
- Mount your music directory to `/radio/music`
- In your Liquidsoap script change path to your music directory to `/radio/music`

#### docker run
```
docker run --name liquidsoap -d --restart=always \
--volume /path/to/your/script.liq:/radio/script.liq \
--volume /path/to/your/music:/radio/music \
pltnk/liquidsoap
```
#### docker-compose.yml
```
liquidsoap:
  image: pltnk/liquidsoap
  container_name: liquidsoap
  restart: always
  volumes:
    - /path/to/your/script.liq:/radio/script.liq
    - /path/to/your/music:/radio/music
```
