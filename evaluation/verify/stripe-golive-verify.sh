#!/usr/bin/env bash
# HARD VERIFY: PASS when stripe.settings has environment=live AND apikey.live.public is set to
# pk_live_GOLIVE_777. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
env=$(drush config:get stripe.settings environment --format=string 2>/dev/null)
pub=$(drush config:get stripe.settings apikey.live.public --format=string 2>/dev/null)
if [ "$env" = "live" ] && [ "$pub" = "pk_live_GOLIVE_777" ]; then
  echo "PASS environment=$env live.public=$pub"; exit 0
else
  echo "FAIL environment=$env live.public=$pub"; exit 1
fi
