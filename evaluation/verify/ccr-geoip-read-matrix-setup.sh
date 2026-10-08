#!/usr/bin/env bash
# Introspection SETUP: write a known geoip country matrix (DE => EUR) + logic country.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_currency_resolver_geoip.currency_mapping")->set("logic","country")->set("matrix", ["DE" => "EUR"])->save();' >/dev/null 2>&1
echo "setup: geoip matrix DE=>EUR"
