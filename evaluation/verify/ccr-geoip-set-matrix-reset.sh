#!/usr/bin/env bash
# Execution RESET: remove the geoip mapping so verify FAILs until the agent sets US=>USD.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_currency_resolver_geoip.currency_mapping")->delete();' >/dev/null 2>&1
echo "reset: geoip mapping cleared (target US=>USD)"
