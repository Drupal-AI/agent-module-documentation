#!/usr/bin/env bash
# Introspection SETUP: ensure the leaflet_demo submodule is enabled, so an inspecting agent
# can confirm its status and showcase page live. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install leaflet_demo -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: leaflet_demo enabled"
