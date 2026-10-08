#!/usr/bin/env bash
# Introspection SETUP: enable migmag_callback_upgrade (no-op on core >= 9.2). Idempotent.
set -uo pipefail
cd /var/www/html
drush en migmag_callback_upgrade -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migmag_callback_upgrade enabled (inert on this core)"
