#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (disabled, no redirect). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset readonlymode.settings enabled 0 -y >/dev/null 2>&1
drush cset readonlymode.settings url '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: readonlymode enabled=0 url=''"
