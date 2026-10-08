#!/usr/bin/env bash
# Execution CLEANUP: restore baseline (module enabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install jquery_deprecated_functions -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jquery_deprecated_functions re-enabled (baseline)"
