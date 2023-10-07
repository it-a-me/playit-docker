FROM docker.io/debian:stable-slim
RUN apt-get -y update && apt-get -y install gpg curl
RUN curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/playit.gpg
RUN echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" > /etc/apt/sources.list.d/playit-cloud.list
RUN apt-get -y update && apt-get -y install playit

CMD ["playit", "--secret_path /data/config", "--stdout"]
