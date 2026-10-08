#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default (20). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset acquia_perz_push.settings cis.queue_bulk_max_size 20 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: acquia_perz_push.settings cis.queue_bulk_max_size reset to 20"
