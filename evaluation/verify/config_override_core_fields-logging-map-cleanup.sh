#!/usr/bin/env bash
# Introspection CLEANUP: restore dblog.settings:row_limit to its default 1000. Leaves dblog
# enabled (site default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set dblog.settings row_limit 1000 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dblog.settings:row_limit restored to 1000"
