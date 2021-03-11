This is a docker image with a few helpful features (R, tidyverse, stan, bioconductor) for statistical and ML work, I use it on dnanexus machines.

Usage: 
`dx run my_cwick --ssh -i "image=nicokist/dnanexus_working_environment"`

## Requirements
The my_cwick applet needs to be present in the project you're working on. Either copy it over from another project or build it as follows:

```
git clone https://github.com/dnanexus/cwic.git
cd cwic
dx build -f -d my_cwick
```
## Mounting other projects

```
mkdir /mnt/project2
dxfuse-mount /mnt/project2/ DNANEXUS_PROJECT_NAME
ls /mnt/project2
```




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

