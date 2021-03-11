This is a docker image with a few helpful features for statistical and ML work, I use it on dnanexus machines.

Usage: 
`dx run my_cwick --ssh`
select ` [0] Docker image name (image)`
enter nicokist/dnanexus_working_environment





## For development

git clone this repository
```
# sudo chown dnanexus /var/run/docker.sock ## Only if you're on a dnanexus host.
docker build docker_working_environment -t stan_docker
docker run --user rstudio -v $HOME:/home/rstudio -it stan_docker bash
```
For additional sessions in the same container:
```
docker exec --user rstudio -it <container name> bash
```

Discover the container name with `docker ps` it will be some kind of scientist experiencing an emotion (e.g. quizzical_darwin).

