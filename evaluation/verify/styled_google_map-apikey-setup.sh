#!/usr/bin/env bash
# Introspection SETUP: store a known Google Maps API key + auth method in
# styled_google_map.settings so an inspecting agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set styled_google_map.settings styled_google_map_google_auth_method 1 -y >/dev/null 2>&1
drush config:set styled_google_map.settings styled_google_map_google_apikey 'AIzaSyEVAL-known-key-001' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: styled_google_map.settings apikey=AIzaSyEVAL-known-key-001 auth_method=1 (API Key)"
