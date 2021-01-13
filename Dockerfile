FROM rocker/tidyverse
RUN apt update
RUN apt install -y libv8-dev libigraph-dev vim
# start R block
RUN echo "install.packages(c('rstan','brms','tidybayes','seqinr'))" | R
RUN echo "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))" | R
RUN echo "install.packages('BiocManager')"|R
RUN echo "cmdstanr::install_cmdstan()" | sudo -u rstudio R
RUN echo "BiocManager::install(c('limma', 'proDA'))"|R
RUN mkdir /home/rstudio/.r/
RUN echo "CXX14FLAGS=-O3 -march=native -mtune=native -fPIC\
    CXX14=g++" > /home/rstudio/.r/Makevars


## end R Block

COPY homedir/* /home/rstudio/
