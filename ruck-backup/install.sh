#!/usr/bin/env bash

systemd_user_directory="/$HOME/.config/systemd/user"
if [[ -d "$systemd_user_directory" ]]; then
  ln --symbolic --force "$PWD/ruck-backup.service" \
     "$systemd_user_directory/ruck-backup.service"
  ln --symbolic --force "$PWD/ruck-backup.timer" \
     "$systemd_user_directory/ruck-backup.timer"
fi
