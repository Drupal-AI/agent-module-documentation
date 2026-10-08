#!/usr/bin/env bash
# Introspection SETUP: ensure the htmx_debug submodule is ENABLED, so an inspecting agent can
# report its status from the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en htmx_debug -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "setup: htmx_debug enabled"
