#!/usr/bin/env bash
# Execution RESET: clear the Google Maps API key (verify must fail until agent sets it).
set -uo pipefail
cd /var/www/html
drush cset google_map_field.settings google_map_field_apikey '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: google_map_field_apikey cleared"
