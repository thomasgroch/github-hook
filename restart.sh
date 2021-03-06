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
    echo "[${APP}] $1"
}

# PID_TO_KILL=$(cat "${PID_FILE}")
# [ -s "${PID_FILE}" ] && log "Killing process" && ps aux|awk "/[b]in\/lt .*${APP}/ {print $2}"|xargs kill -9
# kill -9 $PID_TO_KILL
log "Killing ${APP} process"
ps aux|awk "/[b]in\/lt .*${APP}/ {print $2}"|xargs kill -9
sleep 3s

log "Starting ${APP} tunnel on port ${PORT} [pid=$(cat ${PID_FILE})]"

/usr/local/bin/lt --subdomain "${APP}" --port $PORT \
	> "${STDOUT_FILE}" \
	2> "${STDERR_FILE}" \
	& echo $! > "${PID_FILE}"