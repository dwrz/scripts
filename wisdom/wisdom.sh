#!/usr/bin/env bash

if ! [[ -x "$(command -v fortune)" ]]; then
  echo "fortune not installed" >&2
  exit 1
fi

fortune -a "$HOME"/ruck/oo/scripts/wisdom/*.fortune
