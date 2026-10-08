#!/usr/bin/env bash
# Introspection CLEANUP: remove the swagger-ui library directory created by the matching
# setup. Baseline on this site is "library not installed". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/swagger-ui
drush cr >/dev/null 2>&1
echo "cleanup: web/libraries/swagger-ui removed"
