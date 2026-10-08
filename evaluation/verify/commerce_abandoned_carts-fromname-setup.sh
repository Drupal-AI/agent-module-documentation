#!/usr/bin/env bash
# Introspection SETUP: set a KNOWN From name on commerce_abandoned_carts.settings.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_abandoned_carts.settings")->set("from_name", "ACME Store")->save();' >/dev/null 2>&1
echo "setup: from_name=ACME Store"
