#!/usr/bin/env bash
# Introspection SETUP: set the local-stock transactions retention to 'delete' for an agent to
# read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stock_local.transactions")->set("transactions_retention","delete")->save();' >/dev/null 2>&1
echo "setup: commerce_stock_local.transactions transactions_retention=delete"
