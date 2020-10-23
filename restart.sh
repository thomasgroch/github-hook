#!/bin/bash

APP=$1
PORT=${2:-80}
PID_PATH=$HOME/pids

mkdir -p $PID_PATH; touch "${PID_PATH}/lt_${APP}.pid"
log() {
    echo "[$(date)] $1"
}

log "Killing ${APP} process"
[ -e $PID_PATH/$APP.pid ] && kill $(cat $PID_PATH/$APP.pid)
sleep 3s

log "Starting ${APP} tunnel"
/usr/local/bin/lt --subdomain "${APP}" --port $PORT \
	> $HOME/$APP.stdout \
	2> $HOME/$APP.stderr \
	& echo $! > $PID_PATH/$APP.pid