#!/usr/bin/env bash
# Execution RESET: force the default amount formatter back to currency_basic, so verify FAILS
# until the agent selects the Intl formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("currency.amount_formatting")->set("plugin_id", "currency_basic")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: currency.amount_formatting plugin_id = currency_basic"
