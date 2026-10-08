#!/usr/bin/env bash
# reset: jsonapi_include.settings use_include_query=false
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("jsonapi_include.settings")->set("use_include_query", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jsonapi_include.settings use_include_query=false"
