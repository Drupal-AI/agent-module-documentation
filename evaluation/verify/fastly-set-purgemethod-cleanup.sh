#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("fastly.settings"); $c->clear("purge_method"); $c->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fastly.settings purge_method cleared"
