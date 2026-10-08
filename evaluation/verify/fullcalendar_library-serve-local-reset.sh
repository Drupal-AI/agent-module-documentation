#!/usr/bin/env bash
# Execution RESET: ensure NO local FullCalendar files exist, so the module falls back to the
# jsDelivr CDN and the verify script FAILS until the agent installs a local copy.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/fullcalendar web/libraries/fullcalendar-scheduler
drush cr >/dev/null 2>&1
echo "reset: local FullCalendar files removed (CDN fallback active)"
