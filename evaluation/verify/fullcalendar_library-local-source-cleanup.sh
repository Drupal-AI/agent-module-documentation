#!/usr/bin/env bash
# Introspection CLEANUP: remove the local FullCalendar library files created by setup,
# restoring the baseline where the module serves the assets from the CDN fallback.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/fullcalendar web/libraries/fullcalendar-scheduler
drush cr >/dev/null 2>&1
echo "cleanup: local FullCalendar files removed (back to CDN fallback)"
