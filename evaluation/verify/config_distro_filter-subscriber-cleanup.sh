#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches cleared"
