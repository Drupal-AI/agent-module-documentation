#!/usr/bin/env bash
# Execution RESET: put responsive_menu.settings into a known state that does NOT satisfy the
# build task, so verify FAILs before the agent works. Sets horizontal_menu=account,
# horizontal_breakpoint=Small, drag=false (the opposite of the target build). Exits 0.
set -uo pipefail
cd /var/www/html
drush cset responsive_menu.settings horizontal_menu account -y >/dev/null 2>&1
drush cset responsive_menu.settings horizontal_breakpoint Small -y >/dev/null 2>&1
drush cset responsive_menu.settings horizontal_media_query '(min-width: 500px)' -y >/dev/null 2>&1
drush cset responsive_menu.settings drag 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: responsive_menu.settings -> horizontal_menu=account horizontal_breakpoint=Small drag=false (build target not met)"
