#!/usr/bin/env bash
# Restore baseline: leave cva enabled (cumulative install baseline).
set -uo pipefail
cd /var/www/html
drush pm:install cva -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cva left enabled (baseline)"
