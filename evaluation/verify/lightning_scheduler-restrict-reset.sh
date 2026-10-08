#!/usr/bin/env bash
# Execution RESET: restore shipped defaults (time_step 60, allow_past_dates true) so verify
# (which wants time_step 3600 AND allow_past_dates false) FAILS until the agent applies both.
set -uo pipefail
cd /var/www/html
drush cset lightning_scheduler.settings time_step 60 -y >/dev/null 2>&1
drush cset lightning_scheduler.settings allow_past_dates 1 -y >/dev/null 2>&1
echo "reset: lightning_scheduler.settings time_step=60, allow_past_dates=true"
