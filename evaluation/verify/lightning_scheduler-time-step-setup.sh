#!/usr/bin/env bash
# Introspection SETUP: set Lightning Scheduler's time_step to a known, non-default value (900)
# so an agent can read the configured value back.
set -uo pipefail
cd /var/www/html
drush cset lightning_scheduler.settings time_step 900 -y >/dev/null 2>&1
echo "setup: lightning_scheduler.settings time_step = 900"
