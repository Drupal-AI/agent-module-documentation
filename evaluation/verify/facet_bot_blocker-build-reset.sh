#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete the settings object so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush cdel facet_bot_blocker.settings -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: facet_bot_blocker.settings deleted"
