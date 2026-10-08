#!/usr/bin/env bash
# Execution RESET: restore drupical.settings to install defaults (limit=5, max_age=86400,
# cron_interval=21600) so the "configure the settings" task starts from a known baseline
# that differs from the target values.
set -uo pipefail
cd /var/www/html
drush cset drupical.settings limit 5 -y >/dev/null 2>&1
drush cset drupical.settings max_age 86400 -y >/dev/null 2>&1
drush cset drupical.settings cron_interval 21600 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: drupical.settings at defaults (limit=5, max_age=86400, cron_interval=21600)"
