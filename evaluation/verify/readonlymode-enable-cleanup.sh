#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default (disabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset readonlymode.settings enabled 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: readonlymode enabled=0"
