FROM openjdk:14-jdk-alpine

COPY eula.txt /papermc/data/eula.txt

ARG MC_VERSION="1.16.1"
ARG PAPER_BUILD="latest"

ENV RCON_PW="pls change me thank" \
    JAVA_OPTS=""

RUN apk add bash && \
    mkdir -p /opt/paper && \
    adduser -h /opt/paper -s /bin/bash -D -u 1001 minecraft

RUN wget \
        https://github.com/itzg/rcon-cli/releases/download/1.4.8/rcon-cli_1.4.8_linux_amd64.tar.gz \
        -O /tmp/rcon-cli.tar.gz && \
        mv /tmp/rcon-cli.tar.gz /usr/local/bin/rcon-cli

RUN wget \
    https://papermc.io/api/v1/paper/${MC_VERSION}/${PAPER_BUILD}/download \
    -O /opt/paper/paper-wrapper.jar && \
    chown -R minecraft:minecraft /opt/paper

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
EXPOSE 25565/udp
VOLUME /data/papermc
VOLUME /data/worlds
