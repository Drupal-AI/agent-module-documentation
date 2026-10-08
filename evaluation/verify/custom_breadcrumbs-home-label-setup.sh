#!/usr/bin/env bash
# Introspection SETUP: set the global Home-crumb label to 'Start', so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush config:set custom_breadcrumbs.settings home_link 'Start' -y >/dev/null 2>&1
echo "setup: custom_breadcrumbs.settings home_link=Start"
