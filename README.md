This is a docker image with a few helpful features (R, tidyverse, stan, bioconductor) for statistical and ML work, I use it on dnanexus machines.

Usage: 
`dx run my_cwic --ssh -i "image=nicokist/dnanexus_working_environment"`

Note that it may take some time (~5 min) to download the docker image from [docker.com](https://hub.docker.com/repository/docker/nicokist/dnanexus_working_environment), during this time the message "Waiting for the cwic container to start.." will be shown.

You may want to run `dx login` to ensure you have the correct credentials within the cwick environment.

By default these containers are not persistent.

## Requirements
The my_cwick applet needs to be present in the project you're working on. Either copy it over from another project or build it as follows:

```
git clone https://github.com/dnanexus/cwic.git
cd cwic
dx build -f -d my_cwic
```
## Mounting other projects

```
dx login
mkdir /mnt/project2
dxfuse-mount /mnt/project2/ DNANEXUS_PROJECT_NAME
ls /mnt/project2
```

