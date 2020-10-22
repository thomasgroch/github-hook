#!/bin/bash
mkdir -p /home/pi/pids/; touch /home/pi/pids/lt_github_hook.pid
echo "$(date) Killing the processes"
[ -e /home/pi/pids/lt_github_hook.pid ] && kill $(cat /home/pi/pids/lt_github_hook.pid)
sleep 3s

echo "$(date) Starting github-hook tunnel"
/usr/local/bin/lt --subdomain 'github-hook' --port 5000 > /home/pi/lt_github_hook_stdout.txt 2> /home/pi/lt_github_hook_stderr.txt & echo $! > /home/pi/pids/lt_github_hook.pid