## docker-liquidsoap
Dockerfile for running [Liquidsoap](https://www.liquidsoap.info/) in a container. \
Just mount your Liquidsoap script and you are good to go!

### Installation:
You can either pull the image from Dockerhub \
`docker pull pltnk/liquidsoap` \
or build it yourself \
`docker build -t pltnk/liquidsoap github.com/pltnk/docker-liquidsoap`

### Configuration:
Change the name of your Liquidsoap script file to `script.liq` \
and mount it to `/etc/liquidsoap/script.liq`

#### docker run
```
docker run --name liquidsoap -d --restart=always \
--volume /path/to/your/script.liq:/etc/liquidsoap/script.liq \
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
```
