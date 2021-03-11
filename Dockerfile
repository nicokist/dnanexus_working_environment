FROM rocker/tidyverse
LABEL description="Docker image for work on dnanexus using R"
LABEL maintainer="Nico Kist"

## CWIC stuff taken from https://github.com/dnanexus/cwic/blob/main/docker/Dockerfile
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean \
    && apt-get update \
    && apt-get install -y \
        curl \
        gcc \
        fuse \
        git \
        jq \
        locales \
        locales-all \
        python3-pip \
        vim \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Encoding settings
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

# Set python3 as default python implementation
## NCK: Dnanexus wants this, I don't love it.
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install docker (I don't love this either)
RUN curl -fsSL get.docker.com -o get-docker.sh \
    && sh get-docker.sh

RUN pip3 install --no-cache-dir \
    dxpy==v0.305.0

# Install dxfuse
RUN wget https://github.com/dnanexus/dxfuse/releases/download/v0.23.2/dxfuse-linux -P /usr/local/bin/ \
    && mv /usr/local/bin/dxfuse-linux /usr/local/bin/dxfuse \
    && chmod +x /usr/local/bin/dxfuse

RUN mkdir -p /project /scratch /home/dnanexus /home/rstudio

CMD ["/bin/bash"]

WORKDIR /home/rstudio
ENV HOME=/home/rstudio

# Set cwic prompt
RUN echo 'PS1="\001$(tput setaf 3)\002\001$(tput bold)\002root@cwic:\\w# \001$(tput sgr0)\002"' >> /etc/bash.bashrc

# Update stty size upon login to the container (stty size is used by dx printing
# functions for proper formatting), if COLUMNS and LINES variables are passed
RUN echo 'if [[ -n $COLUMNS ]]; then stty columns $COLUMNS; fi; if [[ -n $LINES ]]; then stty rows $LINES; fi' >> /etc/bash.bashrc

### END CWIC STUFF
## Install R dependencies.

RUN apt update
RUN apt install -y libv8-dev libigraph-dev vim
# start R block
RUN echo "install.packages(c('rstan','brms','tidybayes','seqinr'))" | R
RUN echo "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))" | R
RUN echo "install.packages('BiocManager')"|R
RUN echo "cmdstanr::install_cmdstan()" | R
RUN echo "BiocManager::install(c('limma', 'proDA','sva'))"|R
RUN mkdir /home/cwic/.r/
RUN echo "CXX14FLAGS=-O3 -march=native -mtune=native -fPIC\
    CXX14=g++" > /home/cwic/.r/Makevars


## end R Block

COPY homedir/* /home/cwic/
