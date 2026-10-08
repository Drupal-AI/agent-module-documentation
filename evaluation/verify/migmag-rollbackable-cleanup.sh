#!/usr/bin/env bash
# CLEANUP: restore baseline (migmag_rollbackable enabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx migmag_rollbackable || drush en migmag_rollbackable -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migmag_rollbackable enabled (baseline)"
