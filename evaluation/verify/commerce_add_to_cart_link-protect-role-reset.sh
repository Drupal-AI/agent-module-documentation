#!/usr/bin/env bash
# Execution RESET: clear csrf_token.roles (no role protected) in commerce_add_to_cart_link.settings
# so verify FAILS until the agent protects the authenticated role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_add_to_cart_link.settings")->set("csrf_token.roles", [])->save();
' >/dev/null 2>&1
echo "reset: commerce_add_to_cart_link.settings csrf_token.roles = [] (no protection)"
