#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Heroku Rails Console
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💸
# @raycast.argument1 { "type": "text", "placeholder": "Dyno Name" }
# @raycast.packageName Heroku Run Rails Console

# Documentation:
# @raycast.description Heroku Run Rails Console
# @raycast.author Gary Tou
# @raycast.authorURL https://github.com/garyhtou

# Shorthands:
# .1234 will open PR #1234's deployment (bank--pr-1234)
# bank will open the Production deployment (bank-hackclub) with a confirmation prompt

dyno_name=$1

# Verify that dyno_name argument exists
if [[ -z "$dyno_name" ]]; then
  echo "\"Dyno Name\" is required"
  exit 1
fi

# Substitute shorthands
if [[ $dyno_name = "bank" ]]; then
  dyno_name="bank-hackclub"
elif [[ "$dyno_name" =~ ^\.([[:digit:]]+)$ ]]; then
  dyno_name="bank--pr-${BASH_REMATCH[1]}"
fi

echo "Opening Heroku Dyno \"$dyno_name\""

# Runs in Terminal.app (default macOS terminal)
osascript -e "
tell application \"Terminal\"
    do script \"heroku run rails c -a $dyno_name;\"
end tell
"