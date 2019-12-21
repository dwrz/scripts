#!/usr/bin/env bash

# How many minutes to wait before displaying a warning.
WARNING_MINUTES=15

repos=(
  "$HOME/ruck/oo/journal/"
  "$HOME/ruck/oo/org/"
)

for d in "${repos[@]}"; do
  if ! [[ -d "$d" ]]; then
    printf "%s is not a directory" "%d" >&2
    continue
  fi

  cd "$d" || exit 1

  if ! [[ -d "$d/.git" ]]; then
    printf "%s is not a git repo; ignoring" "%d" >&2
    continue
  fi

  if [[ -z "$(git status --porcelain)" ]]; then
    # OK; nothing to commit.
    continue
  fi

  last_commit_time=$(git log -1 --date=unix --format=%cd)
  current_time=$(date +%s)
  elapsed_time_sec=$((current_time - last_commit_time))
  elapsed_time_min=$((elapsed_time_sec / 60))

  echo "$elapsed_time_min"

  if ! [[ $elapsed_time_min -ge $WARNING_MINUTES ]]; then
    # Less than fifteen minutes have gone by.
    continue
  fi

  msg=$(
    printf \
      "Last commit for %s was more than 15 minutes ago (%d min)." \
      "$d" "$elapsed_time_min" \
     )
  notify-send "WARNING" "$msg"

done
