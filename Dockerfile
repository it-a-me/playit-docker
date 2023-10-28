FROM docker.io/rust:alpine as BUILDER
ARG VERSION
# builder image
RUN apk add git musl-dev curl
RUN curl -L https://github.com/playit-cloud/playit-agent/archive/refs/tags/v${VERSION}.tar.gz | tar xz
RUN mv playit-agent-${VERSION} /src
WORKDIR /src
# cache dependencies
RUN cargo fetch
RUN cargo build --release

# output image
FROM docker.io/alpine
# alpine's default shell ash doesn't respect docker's default sig
STOPSIGNAL SIGKILL
COPY --from=BUILDER /src/target/release/playit-cli /usr/bin/playit
# volume for the playit config file
VOLUME "/config"
CMD ["/usr/bin/playit", "--secret_path", "/config/playit.toml", "--stdout"]
