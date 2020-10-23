#!/bin/bash

APP=$1
log "$(date) $APP Status check"

log() {
    echo "$(date) $1"
}
restart() {
    cd $HOME/$APP/ && sh restart.sh
}

if [[ $(ps aux | grep '$APP') ]]; then
  log "Service is running"
elif [[ $(cat "${HOME}/lt_${APP}.stdout"| grep '$APP') ]]; then
  log "Wrong domain. Restarting Service."; restart
else
  log "Service is stopped. Starting"; restart
fi