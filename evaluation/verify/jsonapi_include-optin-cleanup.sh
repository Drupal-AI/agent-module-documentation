#!/usr/bin/env bash
# cleanup: jsonapi_include.settings use_include_query=false (default)
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("jsonapi_include.settings")->set("use_include_query", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jsonapi_include.settings use_include_query=false (default)"
