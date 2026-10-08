#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline empty fixed-rates config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("currency.exchanger.fixed_rates")->set("rates", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: currency.exchanger.fixed_rates reset to []"
