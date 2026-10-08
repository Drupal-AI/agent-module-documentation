#!/usr/bin/env bash
# Introspection CLEANUP: restore drupical.settings install defaults (limit=5, max_age=86400,
# cron_interval=21600).
set -uo pipefail
cd /var/www/html
drush cset drupical.settings limit 5 -y >/dev/null 2>&1
drush cset drupical.settings max_age 86400 -y >/dev/null 2>&1
drush cset drupical.settings cron_interval 21600 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: drupical.settings restored to defaults (limit=5, max_age=86400, cron_interval=21600)"
