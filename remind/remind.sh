#!/usr/bin/env bash

notify-send "REMINDER" "$*"

sender="$(pass dwrz/email)"
recipient="$(pass dwrz/sms-email)"
msg=$(cat << EOF
To: $recipient
From: $sender
Subject: REMINDER

$@
EOF
   )

echo "$msg" | "$HOME/.msmtpqueue/msmtp-enqueue.sh" \
		-oi -f "$sender" -oep -odi -t

"$HOME/.msmtpqueue/msmtp-runqueue.sh" > /dev/null 2>&1
