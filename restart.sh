#!/bin/bash

APP=$1
PORT=${2:-80}

SCRIPT_HOME="${HOME}/lt"
STDOUT_FILE="${SCRIPT_HOME}/${APP}.stdout"
STDERR_FILE="${SCRIPT_HOME}/${APP}.stderr"
PID_PATH="${SCRIPT_HOME}/pids"
PID_FILE="${PID_PATH}/${APP}.pid"

mkdir -p $PID_PATH; touch "${STDERR_FILE}" "${STDOUT_FILE}" "${PID_FILE}"

log() {
    echo "[$(date)][${APP}] $1"
}

[ -s "${PID_FILE}" ] && log "Killing process" && kill -9 $(cat "${PID_FILE}")
sleep 3s

log "Starting ${APP} tunnel on port ${PORT} [pid=${PID_FILE}]"

/usr/local/bin/lt --subdomain "${APP}" --port $PORT \
	> "${STDOUT_FILE}" \
	2> "${STDERR_FILE}" \
	& echo $! > "${PID_FILE}"