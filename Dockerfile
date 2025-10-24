FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fortune-mod fortunes cowsay netcat-openbsd socat && \
    ln -s /usr/games/fortune /usr/local/bin/fortune && \
    ln -s /usr/games/cowsay /usr/local/bin/cowsay && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY wisecow.sh /app/wisecow.sh

RUN chmod +x /app/wisecow.sh

EXPOSE 4499

CMD ["/app/wisecow.sh"]
