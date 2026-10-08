#!/usr/bin/env bash
# Introspection SETUP: configure a fixed EUR->USD exchange rate of 1.4 via the currency
# module's fixed-rates provider, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fixed = \Drupal::service("plugin.manager.currency.exchange_rate_provider")->createInstance("currency_fixed_rates");
  $fixed->save("EUR", "USD", "1.4");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fixed rate EUR->USD = 1.4 in currency.exchanger.fixed_rates"
