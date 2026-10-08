#!/usr/bin/env bash
# Introspection SETUP: ensure the ept_core_starterkit module is enabled so its Drush generator
# is discoverable on the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install ept_core_starterkit -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "setup: ept_core_starterkit enabled (provides the ept:module generator)"
