#!/usr/bin/env bash
# Introspection CLEANUP: restore transactions_retention to the shipped default 'keep'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stock_local.transactions")->set("transactions_retention","keep")->save();' >/dev/null 2>&1
echo "cleanup: transactions_retention restored to keep"
