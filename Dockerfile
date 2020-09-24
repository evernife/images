# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: Java (glibc support)
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        openjdk:8-jre-slim

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

RUN apt-get update -y \
 && apt-get install -y curl ca-certificates openssl git tar sqlite fontconfig tzdata iproute2 \
 && apt-get install wget \
 && apt-get install unzip \
 && useradd -d /home/container -m container

#YourKit Start
RUN wget https://www.yourkit.com/download/docker/YourKit-JavaProfiler-2020.9-docker.zip -P /tmp/ && \
  unzip /tmp/YourKit-JavaProfiler-2020.9-docker.zip -d /usr/local && \
  rm /tmp/YourKit-JavaProfiler-2020.9-docker.zip
#Yourkit End

USER container
ENV  USER=container HOME=/home/container

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
