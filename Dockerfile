FROM ubuntu:latest

RUN apt update && apt upgrade

RUN apt install -y build-essential python3-pip git fish vim wget strace sudo

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Kolkata

RUN apt install tzdata

RUN adduser --disabled-password --gecos '' anon

RUN adduser anon sudo

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY ./data /home/anon/

USER anon

RUN cd /home/anon/ && git clone https://github.com/pwndbg/pwndbg && cd pwndbg && TZ="Asia/Kolkata" bash ./setup.sh

RUN sudo -H python3 -m pip install pwntools

CMD ["fish"]
