#!/usr/bin/env bash
# Introspection SETUP: set a known bulk queue max size. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset acquia_perz_push.settings cis.queue_bulk_max_size 37 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: acquia_perz_push.settings cis.queue_bulk_max_size = 37"
