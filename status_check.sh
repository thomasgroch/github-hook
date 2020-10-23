#!/bin/bash

APP=$1
PORT=$2

log() {
    echo "[$(date)] $1"
}

log "Status check ${APP} on port ${PORT}"

if [[ $(ps aux | grep '$APP') ]]; then
  log "Service is running"
elif [[ $(cat "${HOME}/lt_${APP}.stdout"| grep '$APP') ]]; then
  log "Wrong domain. Restarting Service."
  cd $HOME/$APP/ && sh restart.sh $1 $2
else
  log "Service is stopped. Starting"
  cd $HOME/$APP/ && sh restart.sh $1 $2
fi