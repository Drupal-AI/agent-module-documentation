#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults of commerce_add_to_cart_link.settings
# (csrf_token.roles = [] , redirect_back = false). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("commerce_add_to_cart_link.settings");
  $c->set("csrf_token.roles", [])->set("redirect_back", FALSE)->save();
' >/dev/null 2>&1
echo "cleanup: commerce_add_to_cart_link.settings restored to defaults (roles=[], redirect_back=false)"
