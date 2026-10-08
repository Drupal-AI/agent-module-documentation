#!/usr/bin/env bash
# Introspection SETUP: write a known Google Maps API key into google_map_field.settings so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_map_field.settings google_map_field_apikey 'gmf_probe_key_7g2x' -y >/dev/null 2>&1
drush cset google_map_field.settings google_map_field_auth_method 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: google_map_field.settings google_map_field_apikey=gmf_probe_key_7g2x"
