#!/bin/bash

APP=$1
PORT=$2

SCRIPT_HOME="${HOME}/lt"
LT_STDOUT_FILE="${SCRIPT_HOME}/${APP}.stdout"
PID_PATH="${SCRIPT_HOME}/pids"
PID_FILE="${PID_PATH}/${APP}.pid"

log() {
    echo "[$(date)][${APP}] $1"
}

touch "${LT_STDOUT_FILE}"
if [[ -s $PID_FILE && -s $LT_STDOUT_FILE ]]; then
	log "has std out logs"
	log 'now checking domain'
	echo "$(cat $ | grep $APP)"
	if [[ ! -s $LT_STDOUT_FILE ]]; then
		log "Ops, ${LT_STDOUT_FILE} is empty"
	elif [[ $(cat "${LT_STDOUT_FILE}"| grep "${APP}") ]]; then
		log "but, got wrong domain! Restarting."
	else
		log "all good."
	fi
else
  log "${APP} is not running. Starting"
  cd "${HOME}/${APP}/" && sh restart.sh $1 $2
fi











