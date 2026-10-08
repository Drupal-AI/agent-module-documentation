#!/usr/bin/env bash
# Introspection SETUP: set cdn scheme to http://. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set cdn.settings scheme 'http://' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cdn.settings scheme = http://"
