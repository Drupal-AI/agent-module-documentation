#!/usr/bin/env bash
# Introspection CLEANUP: rebuild caches. gin_type_tray is left enabled (it is a baseline
# campaign module); nothing to tear down. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches rebuilt (gin_type_tray remains enabled)"
