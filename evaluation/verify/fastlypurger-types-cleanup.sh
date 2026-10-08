#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("purge.plugins"); $c->clear("purgers"); $c->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: purge.plugins purgers cleared"
