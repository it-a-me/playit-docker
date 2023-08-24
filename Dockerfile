FROM docker.io/debian:stable-slim
RUN apt-get -y update && apt-get -y install gpg curl bash
RUN curl -Ssl -o /etc/apt/trusted.gpg.d/playit.asc https://playit-cloud.github.io/ppa/key.gpg
RUN curl -SsL -o /etc/apt/sources.list.d/playit-cloud.list https://playit-cloud.github.io/ppa/playit-cloud.list
RUN apt-get -y update && apt-get -y install playit
RUN apt-get -y remove gpg curl
RUN mkdir /data
CMD ["playit", "--config-file /data/config", "--stdout-logs"]