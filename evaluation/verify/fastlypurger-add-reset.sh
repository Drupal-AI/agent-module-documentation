#!/usr/bin/env bash
# Execution RESET: ensure NO Fastly purger is registered so verify fails until agent adds it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("purge.plugins"); $c->clear("purgers"); $c->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: purge.plugins has no purgers"
