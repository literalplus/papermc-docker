#!/usr/bin/env bash

echo "Launching papermc-docker!"

java \
    -server \
    -XX:MaxRAMPercentage=75 \
    ${EXTRA_JAVA_OPTS} \
    -jar /opt/paper/paper-wrapper.jar \
    nogui \
    ${EXTRA_PAPER_OPTS}

echo "Server exited with code $?"
