FROM ubuntu:focal
RUN apt-get update
RUN apt-get install -y tmux python3 python3-pip
RUN pip3 install fasttext
RUN addgroup --gid 1000 ubuntu 
RUN useradd -u 1000 -g 1000 -s /bin/bash ubuntu
RUN adduser ubuntu sudo
RUN apt-get install -y sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get install -y neovim
RUN apt-get install -y wget git unzip
RUN mkdir /home/ubuntu
WORKDIR /home/ubuntu
COPY homedir/* /home/ubuntu/
