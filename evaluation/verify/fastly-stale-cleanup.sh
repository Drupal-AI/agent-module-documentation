#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("fastly.settings"); $c->clear("stale_while_revalidate"); $c->clear("stale_while_revalidate_value"); $c->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fastly.settings stale_while_revalidate cleared"
