#!/usr/bin/env bash
# Introspection SETUP: enable Read Only Mode with a known redirect URL so an agent can read the
# live state back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset readonlymode.settings enabled 1 -y >/dev/null 2>&1
drush cset readonlymode.settings url '/rom-under-maintenance' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: readonlymode enabled=1 url=/rom-under-maintenance"
