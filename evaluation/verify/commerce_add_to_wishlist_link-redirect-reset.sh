#!/usr/bin/env bash
# Execution RESET: set redirect_back=false so verify FAILS until the agent enables it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_add_to_cart_link.settings")->set("redirect_back", FALSE)->save();
' >/dev/null 2>&1
echo "reset: commerce_add_to_cart_link.settings redirect_back=false"
