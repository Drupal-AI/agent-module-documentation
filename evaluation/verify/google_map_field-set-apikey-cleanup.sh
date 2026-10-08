#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default (empty API key). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_map_field.settings google_map_field_apikey '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: google_map_field_apikey reset to ''"
