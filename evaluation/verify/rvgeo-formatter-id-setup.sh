#!/usr/bin/env bash
# Introspection SETUP: ensure rest_views_geo is enabled and plugin defs current so the agent
# can read which field formatter it contributes for geolocation fields.
set -uo pipefail
cd /var/www/html
drush en rest_views_geo -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rest_views_geo enabled; field formatter definitions current"
