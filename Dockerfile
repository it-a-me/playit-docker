FROM docker.io/rust:alpine as BUILDER
ENV VERSION=0.15.8

RUN apk add git musl-dev curl
RUN curl -L https://github.com/playit-cloud/playit-agent/archive/refs/tags/v${VERSION}.tar.gz | tar xz
RUN mv playit-agent-${VERSION} playit
WORKDIR /playit
RUN cargo build --release

FROM docker.io/alpine
STOPSIGNAL SIGKILL
COPY --from=BUILDER /playit/target/release/playit-cli /usr/bin/playit
VOLUME "/config"
CMD ["/usr/bin/playit", "--secret_path", "/config/playit.toml", "--stdout"]
