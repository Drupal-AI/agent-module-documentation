#!/usr/bin/env bash
# Execution RESET: restore shipped defaults (time_step 60) so verify (which wants 300) FAILS
# until the agent changes it.
set -uo pipefail
cd /var/www/html
drush cset lightning_scheduler.settings time_step 60 -y >/dev/null 2>&1
drush cset lightning_scheduler.settings allow_past_dates 1 -y >/dev/null 2>&1
echo "reset: lightning_scheduler.settings time_step=60, allow_past_dates=true"
