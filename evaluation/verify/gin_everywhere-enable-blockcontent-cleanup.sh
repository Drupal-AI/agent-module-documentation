#!/usr/bin/env bash
# Execution CLEANUP: restore baseline (gin_everywhere enabled).
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx gin_everywhere || drush en gin_everywhere -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: gin_everywhere re-enabled (baseline)"
