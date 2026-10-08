#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default from_name ("").
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_abandoned_carts.settings")->set("from_name", "")->save();' >/dev/null 2>&1
echo "cleanup: from_name restored to empty"
