FROM openjdk:17-jdk-alpine

ARG MC_VERSION="1.19.3"
ARG PAPER_BUILD="latest"
ARG RCON_CLI_VERSION="1.4.8"

ENV RCON_PW="pls change me thank" \
    JAVA_OPTS=""

RUN apk add bash && \
    mkdir -p /opt/paper && \
    adduser -h /opt/paper -s /bin/bash -D -u 1001 minecraft

RUN wget \
        https://github.com/itzg/rcon-cli/releases/download/${RCON_CLI_VERSION}/rcon-cli_${RCON_CLI_VERSION}_linux_amd64.tar.gz \
        -O /tmp/rcon-cli.tar.gz && \
        tar -xz -C /tmp -f /tmp/rcon-cli.tar.gz rcon-cli && \
        mv /tmp/rcon-cli /usr/local/bin/rcon-cli && \
        chmod +x /usr/local/bin/rcon-cli

RUN wget \
    https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/${PAPER_BUILD}/downloads/paper-${MC_VERSION}-${PAPER_BUILD}.jar \
    -O /opt/paper/paper-wrapper.jar && \
    chown -R minecraft:minecraft /opt/paper

RUN mkdir -p /data/papermc && \
    chown -R minecraft: /data/papermc

COPY eula.txt /data/papermc/eula.txt

WORKDIR /data/papermc
USER minecraft

CMD [ \
    "java", \
    "-server", \
    "-XX:MaxRAMPercentage=75", \
    "-jar", \
    "/opt/paper/paper-wrapper.jar" \
]

EXPOSE 25565/tcp
#VOLUME /data/papermc
VOLUME /data/worlds
