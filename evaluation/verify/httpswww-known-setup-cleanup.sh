#!/usr/bin/env bash
# Introspection CLEANUP: delete httpswww.settings entirely, restoring the shipped baseline
# (the module ships no config/install and no config/schema, so "no config object" IS the
# baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:delete httpswww.settings >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: httpswww.settings deleted (restored to shipped baseline)"
