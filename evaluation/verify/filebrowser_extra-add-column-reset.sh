#!/usr/bin/env bash
# Execution RESET: disable filebrowser_extra so its "modified" metadata column is NOT
# contributed (verify must FAIL until the agent enables it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu filebrowser_extra -y >/dev/null 2>&1
echo "reset: filebrowser_extra disabled"
