FROM debian

RUN apt-get -y update
RUN apt-get -y install curl gpg

RUN curl -SsL https://playit-cloud.github.io/ppa/key.gpg | apt-key add -
RUN curl -SsL -o /etc/apt/sources.list.d/playit-cloud.list https://playit-cloud.github.io/ppa/playit-cloud.list
RUN apt-get -y update
RUN apt-get -y install playit

CMD ["/usr/local/bin/playit"]
