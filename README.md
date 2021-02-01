This is a docker image with a few helpful features for statistical and ML work. I use it on dnanexus machines.

Usage: 
git clone this repository
```
docker build docker_working_environment -t stan_docker
docker run --user rstudio -v `pwd`:/home/rstudio/host -it stan_docker bash
```
For additional sessions in the same container:
```
docker exec --user rstudio -it <container name> bash
```

Discover the container name with `docker ps` it will be some kind of scientist experiencing an emotion (e.g. quizzical_darwin).

