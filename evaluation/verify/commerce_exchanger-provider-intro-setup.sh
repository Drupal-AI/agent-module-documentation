#!/usr/bin/env bash
# Introspection SETUP: create a commerce_exchange_rates config entity that uses the ECB
# provider (base currency EUR) so an inspecting agent can read back the provider plugin.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_exchanger\Entity\ExchangeRates;
  if (!ExchangeRates::load("ce_ecb_intro")) {
    ExchangeRates::create([
      "id" => "ce_ecb_intro", "label" => "ECB Intro Rates", "plugin" => "ecb",
      "configuration" => [
        "manual" => FALSE, "refresh_once" => TRUE, "cron" => 0,
        "use_cross_sync" => TRUE, "base_currency" => "EUR", "mode" => "live",
        "enterprise" => FALSE, "transform_rates" => FALSE, "historical_rates" => FALSE,
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_exchange_rates ce_ecb_intro plugin=ecb base_currency=EUR"
