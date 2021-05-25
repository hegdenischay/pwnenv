FROM ubuntu:latest

RUN apt update && apt upgrade

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Kolkata

RUN apt install -y build-essential python3-pip git fish vim wget strace sudo radare2 python2 gdb

RUN adduser --disabled-password --gecos '' anon

RUN adduser anon sudo

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY ./data /home/anon/

USER anon

# install pwndbg stuff

RUN sudo apt install -y python3-dev python3-pip python3-setuptools libglib2.0-dev libc6-dbg

RUN sudo dpkg --add-architecture i386

RUN sudo apt update && sudo apt install -y libc6-dbg:i386

# RUN cd /home/anon/ && cd pwndbg && TZ="Asia/Kolkata" bash ./setup.sh

RUN sudo -H python3 -m pip install pwntools

CMD ["fish"]
