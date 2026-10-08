#!/usr/bin/env bash
# Execution RESET: clear the 403 access-denied page (system.site:page.403 = '') so verify FAILS
# until the agent sets it via the config object/key the '403 page' field maps to. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set system.site page.403 '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: system.site:page.403 cleared"
