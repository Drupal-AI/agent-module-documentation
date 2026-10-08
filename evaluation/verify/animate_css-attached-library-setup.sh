#!/usr/bin/env bash
# Introspection SETUP: animate_css stores no per-site config; the discoverable fact is the
# asset library it attaches. Ensure the module is enabled so the library is registered. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx animate_css || drush en animate_css -y >/dev/null 2>&1
echo "setup: animate_css enabled; library animate_css/animate is registered and attached on every page"
