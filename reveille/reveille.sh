#!/usr/bin/env bash

GOPATH="$HOME/.go"
PATH="$GOPATH/bin:$PATH"

date="$(date '+%Y%m%d %j/365 %W/52 %u/7')"
date_unix="$(date +%s)"

birth_year="$(pass dwrz/birth-year)"
birth_month="$(pass dwrz/birth-month)"
birth_day="$(pass dwrz/birth-day)"

# TODO: replace this constant with an API request.
# https://www.ssa.gov/cgi-bin/longevity.cgi
ESTIMATED_REMAINING_YEARS=50
estimated_remaining_days=$((ESTIMATED_REMAINING_YEARS * 365))
estimated_remaining_days_fmt="$(numfmt --grouping $estimated_remaining_days)"

age="$(age -year $birth_year -month $birth_month -day $birth_day -output days)"
age_fmt="$(numfmt --grouping $age)"

wisdom="$($HOME/ruck/oo/scripts/wisdom/wisdom.sh)"

message_file="/tmp/reminder-$date_unix"
cat > "$message_file" << EOF
To: dwrz@dwrz.net
From: dwrz@dwrz.net
Subject: $date

You have been on Earth, in this form, for ~$age_fmt days.

You have ~$estimated_remaining_days_fmt days left. You might have more.
Or today could be your last day.

Make the most of the time you have.

Remember:
- If you have the essentials, you have the foundations for happiness.
- You are surrounded by people largely like youself: imperfect and
  evanescent.
- People have invested in you -- with time, energy, money, lessons, and
  perspectives. Living things have given their life to sustain you. You
  owe the world the best version of yourself.
- The ego does not always act in its best interests.
- Beware the sirens' song.
- No plan ever survives initial contact with reality.
- Fatigue does not equal fitness.
- Slow is smooth, and smooth is fast.

QOTD:

$wisdom

EOF

"$HOME/.msmtpqueue/msmtp-enqueue.sh" -oi -f dwrz@dwrz.net -oep -odi -t < "$message_file"
