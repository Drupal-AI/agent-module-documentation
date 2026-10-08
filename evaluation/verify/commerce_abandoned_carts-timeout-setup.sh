#!/usr/bin/env bash
# Introspection SETUP: set a KNOWN send timeout (720) on commerce_abandoned_carts.settings.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_abandoned_carts.settings")->set("timeout", 720)->save();' >/dev/null 2>&1
echo "setup: commerce_abandoned_carts.settings timeout=720"
