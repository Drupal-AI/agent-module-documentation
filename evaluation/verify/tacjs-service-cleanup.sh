#!/usr/bin/env bash
# Introspection CLEANUP: restore services to shipped baseline (no services enabled).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tacjs.settings")->set("services",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tacjs.settings services=[]"
