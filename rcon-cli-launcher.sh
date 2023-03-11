#!/usr/bin/env bash

EXTRA_ARGS=""
RCON_CLI_CONF_FILE="/opt/paper/.rcon-cli.yaml"

if [[ -f "${RCON_CLI_CONF_FILE}" ]]; then
    EXTRA_ARGS="--config ${RCON_CLI_CONF_FILE}"
else
    echo "Config file ${RCON_CLI_CONF_FILE} not found." >&2
    echo "Authentication might not work out of the box." >&2
fi

/opt/paper/rcon-cli-raw ${EXTRA_ARGS} "$@"
