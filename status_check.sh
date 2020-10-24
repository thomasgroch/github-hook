#!/bin/bash

APP=$1
PORT=$2

SCRIPT_HOME="${HOME}/lt"
LT_STDOUT_FILE="${SCRIPT_HOME}/${APP}.stdout"

log() {
    echo "[$(date)] $1"
}

log "Status check ${APP} on port ${PORT}"
$(ps aux | awk "/[b]in\/lt .*${APP}/ {print $2}")

touch "${LT_STDOUT_FILE}"
if [[ $(cat "${LT_STDOUT_FILE}"| grep "${APP}") ]]; then
  log "Wrong domain. Restarting Service."
  cd "${HOME}/${APP}/" && sh restart.sh $1 $2
elif [[ $(ps aux | awk "/[b]in\/lt .*${APP}/ {print $2}") ]]; then
  log "Service is running"
else
  log "Service is stopped. Starting"
  cd "${HOME}/${APP}/" && sh restart.sh $1 $2
fi