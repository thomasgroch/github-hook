#!/bin/bash

APP=$1
PORT=$2

log() {
    echo "[$(date)] $1"
}

log "Status check ${APP} on port ${PORT}"
touch "${HOME}/lt_${APP}.stdout"

if [[ $(cat "${HOME}/lt_${APP}.stdout"| grep "${APP}") ]]; then
  log "Wrong domain. Restarting Service."
  cd "${HOME}/${APP}/" && sh restart.sh $1 $2
elif [[ $(ps aux | awk "/[b]in\/lt .*${APP}/ {print $2}" ]]; then
  log "Service is running"
else
  log "Service is stopped. Starting"
  cd "${HOME}/${APP}/" && sh restart.sh $1 $2
fi