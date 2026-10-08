#!/usr/bin/env bash
# Introspection SETUP: ensure migmag_rollbackable is enabled (baseline) so its destination plugins
# and rollback tables exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx migmag_rollbackable || drush en migmag_rollbackable -y >/dev/null 2>&1
echo "setup: migmag_rollbackable enabled"
