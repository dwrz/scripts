#!/usr/bin/env bash

eval "$(keychain --noask --eval mobile srv-nyc)"

notify-send "INFO" "Starting ruck backup."

if ! [[ "$HOSTNAME" == "earth" ]]; then
  echo "invalid host" >&2
  exit 1
fi

if ! [[ -d "$HOME/ruck" ]]; then
  notify-send "WARNING" "Unable to find ruck at $HOME/ruck."
  echo "unable to find ruck at $HOME/ruck" >&2
  exit 2
fi

error="false"
rsync -av --progress --delete -e "ssh -i $HOME/.ssh/mobile" "$HOME/ruck/" \
      dwrz@mobile:/data/data/com.termux/files/home/ruck/
result=$?
if [[ result -ne 0 ]]; then
  error="true"
  notify-send "WARNING" "Failed to backup ruck to mobile."
fi

rsync -av --progress --delete -e "ssh -i $HOME/.ssh/srv-nyc" "$HOME/ruck/" \
      dwrz@srv-nyc:/home/dwrz/ruck/
result=$?
if [[ result -ne 0 ]]; then
  error="true"
  notify-send "WARNING" "Failed to backup ruck to srv-nyc."
fi

if [[ "$error" == "false" ]]; then
  notify-send "INFO" "Completed ruck backup with no errors."
fi
