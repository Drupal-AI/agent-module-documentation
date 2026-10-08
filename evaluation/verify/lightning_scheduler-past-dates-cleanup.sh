#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (time_step 60, allow_past_dates true).
set -uo pipefail
cd /var/www/html
drush cset lightning_scheduler.settings allow_past_dates 1 -y >/dev/null 2>&1
drush cset lightning_scheduler.settings time_step 60 -y >/dev/null 2>&1
echo "cleanup: lightning_scheduler.settings restored (time_step=60, allow_past_dates=true)"
