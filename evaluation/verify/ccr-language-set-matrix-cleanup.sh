#!/usr/bin/env bash
# Introspection CLEANUP: delete the language mapping config (baseline = did not exist).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_currency_resolver_language.currency_mapping")->delete();' >/dev/null 2>&1
echo "cleanup: language mapping deleted"
