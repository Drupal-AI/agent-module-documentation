#!/usr/bin/env bash
# Introspection SETUP: forbid past-dated scheduling (allow_past_dates = false) so an agent can
# read the current policy back.
set -uo pipefail
cd /var/www/html
drush cset lightning_scheduler.settings allow_past_dates 0 -y >/dev/null 2>&1
echo "setup: lightning_scheduler.settings allow_past_dates = false"
