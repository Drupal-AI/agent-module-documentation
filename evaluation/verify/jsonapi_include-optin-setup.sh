#!/usr/bin/env bash
# setup: jsonapi_include.settings use_include_query=true (opt-in mode)
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("jsonapi_include.settings")->set("use_include_query", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jsonapi_include.settings use_include_query=true (opt-in mode)"
