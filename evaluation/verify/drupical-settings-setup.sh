#!/usr/bin/env bash
# Introspection SETUP: put drupical.settings into a KNOWN state — limit=12, max_age=7200,
# cron_interval=10800 — so an inspecting agent (drush cget drupical.settings) can read the
# configured values back. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset drupical.settings limit 12 -y >/dev/null 2>&1
drush cset drupical.settings max_age 7200 -y >/dev/null 2>&1
drush cset drupical.settings cron_interval 10800 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: drupical.settings limit=12 max_age=7200 cron_interval=10800"
