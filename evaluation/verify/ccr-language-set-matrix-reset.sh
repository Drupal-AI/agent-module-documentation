#!/usr/bin/env bash
# Execution RESET: remove the language mapping so verify FAILs until the agent sets en=>USD.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_currency_resolver_language.currency_mapping")->delete();' >/dev/null 2>&1
echo "reset: language mapping cleared (target en=>USD)"
