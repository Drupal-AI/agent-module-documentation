#!/usr/bin/env bash
# Execution RESET: force Read Only Mode OFF so verify fails until the agent enables it. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset readonlymode.settings enabled 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: readonlymode enabled=0"
