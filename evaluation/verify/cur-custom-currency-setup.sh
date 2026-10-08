#!/usr/bin/env bash
# Introspection SETUP: add a custom currency entity QCU ("Currency Doc Coin") so an agent can
# read it back from live currency config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\currency\Entity\Currency;
  if (!Currency::load("QCU")) {
    Currency::create([
      "currencyCode" => "QCU", "currencyNumber" => "950", "label" => "Currency Doc Coin",
      "sign" => "Q", "subunits" => 100, "roundingStep" => "0.01", "status" => TRUE,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: currency QCU (Currency Doc Coin) created"
