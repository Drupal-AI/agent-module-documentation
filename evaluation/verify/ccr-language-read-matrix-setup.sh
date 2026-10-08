#!/usr/bin/env bash
# Introspection SETUP: write a known language->currency matrix (en => EUR) so the agent can read it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_currency_resolver_language.currency_mapping")->set("matrix", ["en" => "EUR"])->save();' >/dev/null 2>&1
echo "setup: language matrix en=>EUR"
