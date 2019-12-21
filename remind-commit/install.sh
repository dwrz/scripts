#!/usr/bin/env bash

systemd_user_directory="/$HOME/.config/systemd/user"
if [[ -d "$systemd_user_directory" ]]; then
  ln --symbolic --force "$PWD/remind-commit.service" \
     "$systemd_user_directory/remind-commit.service"
  ln --symbolic --force "$PWD/remind-commit.timer" \
     "$systemd_user_directory/remind-commit.timer"
fi
