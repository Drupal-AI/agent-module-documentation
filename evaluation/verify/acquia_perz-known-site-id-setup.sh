#!/usr/bin/env bash
# Introspection SETUP: set a known Site ID in acquia_perz.settings so an inspecting agent can
# read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset acquia_perz.settings api.site_id perzintro_known_site -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: acquia_perz.settings api.site_id = perzintro_known_site"
