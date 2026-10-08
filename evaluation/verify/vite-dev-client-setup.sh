#!/usr/bin/env bash
# Introspection SETUP: ensure vite is enabled and the library cache is fresh so the agent can
# read the module's shipped dev-client library via library.discovery. No persistent state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install vite -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vite enabled; library vite/vite-dev-client discoverable via library.discovery"
