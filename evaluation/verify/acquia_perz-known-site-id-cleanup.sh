#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (empty Site ID). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset acquia_perz.settings api.site_id '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: acquia_perz.settings api.site_id reset to ''"
