#!/bin/bash
echo "$(date) Status check - github-hook:"
if [[ -e /home/pi/lt_stdout.txt && ! $(cat /home/pi/lt_stdout.txt| grep 'github-hook') ]]; then
  echo "$(date) Wrong domain. Service is stopped. Restarting"
  cd /home/pi/github-hook/ && sh restart.sh
elif [[ $(ps aux | awk '/[b]in\/lt .*github-hook/ {print $2}') ]]; then
  echo "$(date) Service is running"
else
  echo "$(date) Service is stopped. Restarting"
  cd /home/pi/github-hook/ && sh restart.sh
fi