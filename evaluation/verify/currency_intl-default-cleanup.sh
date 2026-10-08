#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default amount formatter (currency_basic).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("currency.amount_formatting")->set("plugin_id", "currency_basic")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: currency.amount_formatting plugin_id = currency_basic"
