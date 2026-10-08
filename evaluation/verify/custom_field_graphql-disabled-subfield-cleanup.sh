#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("graphql_compose.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: graphql_compose.settings removed"
