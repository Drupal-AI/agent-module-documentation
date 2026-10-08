#!/usr/bin/env bash
# Introspection SETUP (partial): place ONLY the FullCalendar CORE files locally and leave the
# Scheduler add-on files absent, so the per-file CDN fallback keeps the Scheduler on the CDN.
# An inspecting agent should report that the scheduler script is served from the CDN.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/fullcalendar-scheduler
mkdir -p web/libraries/fullcalendar/lib
for f in web/libraries/fullcalendar/fullcalendar.min.js \
         web/libraries/fullcalendar/fullcalendar.min.css \
         web/libraries/fullcalendar/fullcalendar.print.min.css \
         web/libraries/fullcalendar/locale-all.js \
         web/libraries/fullcalendar/lib/moment.min.js; do
  printf '/* fullcalendar_library eval fixture */\n' > "$f"
done
drush cr >/dev/null 2>&1
echo "setup: FullCalendar core files local, Scheduler files absent (scheduler on CDN)"
