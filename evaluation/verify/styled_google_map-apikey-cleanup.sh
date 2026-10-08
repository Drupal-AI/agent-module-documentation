#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (apikey empty, auth method 1). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set styled_google_map.settings styled_google_map_google_apikey '' -y >/dev/null 2>&1
drush config:set styled_google_map.settings styled_google_map_google_auth_method 1 -y >/dev/null 2>&1
drush config:set styled_google_map.settings styled_google_map_google_client_id '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: styled_google_map.settings restored to defaults (apikey empty, auth_method 1)"
