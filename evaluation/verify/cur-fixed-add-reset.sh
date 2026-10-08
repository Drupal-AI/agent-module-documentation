#!/usr/bin/env bash
# Execution RESET: clear all fixed exchange rates so verify FAILS until the agent adds the
# GBP->USD rate. Restores currency.exchanger.fixed_rates to []. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("currency.exchanger.fixed_rates")->set("rates", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: currency.exchanger.fixed_rates = []"
