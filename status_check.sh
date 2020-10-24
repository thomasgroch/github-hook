#!/bin/bash

APP=$1
PORT=$2

SCRIPT_HOME="${HOME}/lt"
LT_STDOUT_FILE="${SCRIPT_HOME}/${APP}.stdout"
PID_PATH="${SCRIPT_HOME}/pids"
PID_FILE="${PID_PATH}/${APP}.pid"

log() {
    echo "[$(date)] $1"
}
log 'checking domain'
echo "$(cat $LT_STDOUT_FILE| grep $APP)"

touch "${LT_STDOUT_FILE}"
if [[ $(cat "${LT_STDOUT_FILE}"| grep "${APP}") ]]; then
  log "Wrong domain for ${APP}. Restarting Service."
  cd "${HOME}/${APP}/" && sh restart.sh $1 $2
elif [[ -s $PID_FILE ]]	; then
  log "Service ${APP} is running"
else
  log "Service ${APP} is stopped. Starting"
  cd "${HOME}/${APP}/" && sh restart.sh $1 $2
fi