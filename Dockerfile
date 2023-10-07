FROM docker.io/rust:alpine as BUILDER
RUN apk add git musl-dev curl
RUN curl -L https://github.com/playit-cloud/playit-agent/archive/refs/tags/v0.15.8.tar.gz | tar xz
RUN mv playit-agent-* playit
WORKDIR /playit
RUN cargo build --release

FROM docker.io/alpine
COPY --from=BUILDER /playit/target/release/playit-cli /usr/bin/playit
CMD ["/usr/bin/playit", "--secret_path /data/config", "--stdout", "run"]
