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

log "Killing process" && kill $(cat "${PID_FILE}")
rm $STDOUT_FILE
rm $STDERR_FILE
rm $PID_FILE
sleep 3s

log "Starting tunnel:"
log "PORT=${PORT}"
log "Stdout ${STDOUT_FILE}"
log "Stderr ${STDERR_FILE}"
log "Pid ${PID_FILE}"
/usr/local/bin/lt --subdomain "${APP}" --port $PORT \
	> "${STDOUT_FILE}" \
	2> "${STDERR_FILE}" \
	& echo $! > "${PID_FILE}"