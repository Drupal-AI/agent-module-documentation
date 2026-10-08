#!/usr/bin/env bash
# Introspection CLEANUP: baseline keeps migmag_process enabled; re-ensure it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx migmag_process || drush en migmag_process -y >/dev/null 2>&1
echo "cleanup: migmag_process enabled (baseline)"
