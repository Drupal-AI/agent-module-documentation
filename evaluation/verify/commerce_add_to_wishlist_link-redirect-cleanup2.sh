#!/usr/bin/env bash
# Execution CLEANUP: restore redirect_back=false (shipped default). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_add_to_cart_link.settings")->set("redirect_back", FALSE)->save();
' >/dev/null 2>&1
echo "cleanup: commerce_add_to_cart_link.settings redirect_back restored to false"
