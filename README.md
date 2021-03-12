[![Publish Docker image](https://github.com/nicokist/dnanexus_working_environment/actions/workflows/docker-image.yml/badge.svg)](https://github.com/nicokist/dnanexus_working_environment/actions/workflows/docker-image.yml)

This is a docker image with a few helpful features (R, tidyverse, stan, bioconductor) for statistical and ML work, I use it on dnanexus machines.

Usage: 
`dx run my_cwic --ssh -i "image=nicokist/dnanexus_working_environment"`

If you want to use the highly experimental read/write mode:

`dx run my_cwic --ssh -i "image=nicokist/dnanexus_working_environment" -iproject_mount_options='-w'`

You'll find your project directory mounted as a filesystem on /Project/. Note that there are some large conceptual differences between dnanexus storage blobs (more similar to Amazon S3 and google cloud storage) and filesystems, which are resolved by [dxfuse](https://github.com/dnanexus/dxfuse). Avoid having multiple files with the same name stored in DNANexus, which annoyingly it allows.

Note that it may take some time (~5 min) to download the docker image from [docker.com](https://hub.docker.com/repository/docker/nicokist/dnanexus_working_environment), during this time the message "Waiting for the cwic container to start.." will be shown.

You may want to run `dx login` to ensure you have the correct credentials within the cwic environment.

By default these containers are not persistent.



## Requirements
The my_cwic applet needs to be present in the project you're working on. Either copy it over from another project or build it as follows:

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
