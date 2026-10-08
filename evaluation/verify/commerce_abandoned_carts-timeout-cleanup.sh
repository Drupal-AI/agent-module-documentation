#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default timeout (1440).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_abandoned_carts.settings")->set("timeout", 1440)->save();' >/dev/null 2>&1
echo "cleanup: timeout restored to 1440"
