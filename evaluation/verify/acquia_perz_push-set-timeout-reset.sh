#!/usr/bin/env bash
# Execution RESET/CLEANUP: force endpoint_timeout back to shipped default (2), so verify FAILS
# until the agent raises it to 10. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset acquia_perz_push.settings cis.endpoint_timeout 2 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: acquia_perz_push.settings cis.endpoint_timeout = 2"
