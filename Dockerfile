FROM docker.io/eclipse-temurin:21-jdk-alpine AS runner

ENV RCON_PW="pls change me thank" \
    EXTRA_JAVA_OPTS="" \
    EXTRA_PAPER_OPTS=""

RUN apk add bash && \
    mkdir -p /opt/paper && \
    adduser -h /opt/paper -s /bin/bash -D -u 1001 minecraft && \
    mkdir -p /data/papermc && \
    chown -R minecraft: /data/papermc

COPY eula.txt /data/papermc/eula.txt
COPY papermc-launcher.sh /opt/paper/papermc-launcher
COPY rcon-cli-launcher.sh /usr/local/bin/rcon-cli

ARG RCON_CLI_VERSION="1.4.8"
RUN wget \
        https://github.com/itzg/rcon-cli/releases/download/${RCON_CLI_VERSION}/rcon-cli_${RCON_CLI_VERSION}_linux_amd64.tar.gz \
        -O /tmp/rcon-cli.tar.gz && \
        tar -xz -C /tmp -f /tmp/rcon-cli.tar.gz rcon-cli && \
        mv /tmp/rcon-cli /opt/paper/rcon-cli-raw && \
        chmod +x /opt/paper/rcon-cli-raw

ARG MC_VERSION="1.19.3"
ARG PAPER_BUILD="latest"
RUN wget \
    https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/${PAPER_BUILD}/downloads/paper-${MC_VERSION}-${PAPER_BUILD}.jar \
    -O /opt/paper/paper-wrapper.jar && \
    chown -R minecraft:minecraft /opt/paper

WORKDIR /data/papermc
USER minecraft

CMD [ \
    "/opt/paper/papermc-launcher"\
]

EXPOSE 25565/tcp
