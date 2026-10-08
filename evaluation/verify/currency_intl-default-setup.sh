#!/usr/bin/env bash
# Introspection SETUP: make currency_intl the site's default amount formatter, so an agent can
# read back which formatter is active. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("currency.amount_formatting")->set("plugin_id", "currency_intl")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: currency.amount_formatting plugin_id = currency_intl"
