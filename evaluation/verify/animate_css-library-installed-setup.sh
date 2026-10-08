#!/usr/bin/env bash
# Introspection SETUP: the discoverable fact is whether the animate.css file is installed and its
# path. Ensure animate_css is enabled so library.discovery can resolve it. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx animate_css || drush en animate_css -y >/dev/null 2>&1
echo "setup: animate_css enabled; animate_css/animate -> libraries/animate.css/animate.css"
