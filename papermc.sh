#!/usr/bin/env sh

java -server -Xms${MC_RAM} -Xmx${MC_RAM} ${JAVA_OPTS} -jar ${JAR_NAME}.jar nogui
