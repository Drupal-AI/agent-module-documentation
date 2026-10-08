#!/usr/bin/env bash
# Introspection CLEANUP: baseline is gin_everywhere enabled; ensure it stays enabled.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx gin_everywhere || drush en gin_everywhere -y >/dev/null 2>&1
echo "cleanup: gin_everywhere left enabled (baseline)"
