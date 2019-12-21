#!/usr/bin/env bash

systemd_user_directory="/$HOME/.config/systemd/user"
if [[ -d "$systemd_user_directory" ]]; then
  ln --symbolic --force "$PWD/reveille.service" \
     "$systemd_user_directory/reveille.service"
  ln --symbolic --force "$PWD/reveille.timer" \
     "$systemd_user_directory/reveille.timer"
fi
