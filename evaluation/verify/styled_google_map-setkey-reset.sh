#!/usr/bin/env bash
# Execution RESET: blank the Google Maps API key + reset auth method so verify FAILS until
# the agent sets it. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set styled_google_map.settings styled_google_map_google_apikey '' -y >/dev/null 2>&1
drush config:set styled_google_map.settings styled_google_map_google_auth_method 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: styled_google_map.settings apikey blanked"
