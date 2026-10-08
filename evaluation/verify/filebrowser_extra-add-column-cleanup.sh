#!/usr/bin/env bash
# Execution CLEANUP: re-enable filebrowser_extra to restore baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en filebrowser_extra -y >/dev/null 2>&1
echo "cleanup: filebrowser_extra re-enabled (baseline)"
