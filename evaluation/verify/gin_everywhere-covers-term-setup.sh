#!/usr/bin/env bash
# Introspection SETUP: ensure gin_everywhere is enabled so its route behaviour is observable.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx gin_everywhere || drush en gin_everywhere -y >/dev/null 2>&1
echo "setup: gin_everywhere enabled (route-alter observable via GinEverywhereHooks service)"
