#!/usr/bin/env bash
# Execution RESET: force search_enabled=TRUE (baseline) so verify FAILS until the agent
# disables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set menu_select.settings search_enabled 1 -y >/dev/null 2>&1
echo "reset: menu_select.settings search_enabled=true"
