#!/usr/bin/env bash
# Introspection CLEANUP: baseline is "enabled", so just leave the module installed and clear caches.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install jquery_deprecated_functions -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jquery_deprecated_functions left enabled (baseline)"
