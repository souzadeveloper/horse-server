FROM ubuntu:20.04

RUN apt update -y && apt upgrade -y && apt dist-upgrade -y

RUN apt install -y joe wget p7zip-full curl openssh-server build-essential zlib1g-dev libcurl4-gnutls-dev libncurses5

COPY ./LinuxPAServer20.0.tar.gz .

RUN tar –xvf LinuxPAServer20.0.tar.gz