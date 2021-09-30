FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Shih-Sung-Lin

RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
ENV JAVA_HOME=/usr/lib/jdk1.8.0_211
ENV PATH=$PATH:$JAVA_HOME/bin
EXPOSE 4040

# setup
RUN apt-get update
RUN apt-get install -y git g++ software-properties-common build-essential language-pack-en unzip curl wget vim libpam0g-dev libssl-dev cmake cron libssl-dev openssl iputils-ping
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get install -y python3-pip
RUN pip3 install Flask==2.0.1
RUN pip3 install gunicorn==20.1.0

# install jdk
RUN mkdir /temp
RUN mkdir /temp/install
WORKDIR /temp/install
RUN wget https://github.com/frekele/oracle-java/releases/download/8u211-b12/jdk-8u211-linux-x64.tar.gz
RUN tar -zxvf jdk-8u211-linux-x64.tar.gz
RUN cp -R /temp/install/jdk1.8.0_211 /usr/lib/jdk1.8.0_211
RUN ln -s /usr/lib/jdk1.8.0_211/bin/java /etc/alternatives/java

# install spark
RUN mkdir /temp/spark
WORKDIR /temp/spark
RUN curl -L https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz -o spark-3.1.2-bin-hadoop3.2.tgz
RUN tar -zxvf spark-3.1.2-bin-hadoop3.2.tgz

WORKDIR /temp
#ENTRYPOINT /temp/spark/spark-3.1.2-bin-hadoop3.2/bin/spark-shell
CMD nohup /temp/spark/spark-3.1.2-bin-hadoop3.2/bin/spark-shell && exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 hello:app

