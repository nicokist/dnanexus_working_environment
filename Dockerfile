FROM ubuntu:focal
RUN apt-get update
RUN apt-get install -y tmux python3 python3-pip
RUN pip3 install fasttext
RUN addgroup --gid 1000 ubuntu 
RUN useradd -u 1000 -g 1000 ubuntu
RUN apt-get install -y neovim

COPY homedir/* /home/ubuntu
