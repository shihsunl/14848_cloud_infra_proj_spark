FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Shih-Sung-Lin

RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
ENV JAVA_HOME=/usr/lib/jdk1.8.0_211
ENV PATH=$PATH:$JAVA_HOME/bin

# setup
RUN apt-get update
RUN apt-get install -y git g++ software-properties-common build-essential language-pack-en unzip curl wget vim libpam0g-dev libssl-dev cmake cron
RUN apt-get install -y iputils-ping
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt install -y python3-pip

# Download installation
RUN mkdir /temp
WORKDIR /temp
RUN cd /temp
RUN git clone https://github.com/shihsunl/14848_cloud_infra_proj_spark.git

# install
RUN cp -r /temp/14848_cloud_infra_proj_spark/* /temp/
RUN ls /temp
RUN ls /temp/install
WORKDIR /temp/install
RUN ./install.sh

WORKDIR /temp
ENTRYPOINT /temp/install/run.sh /bin/bash

