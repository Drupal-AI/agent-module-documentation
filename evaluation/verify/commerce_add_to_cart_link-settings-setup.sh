#!/usr/bin/env bash
# Introspection SETUP: set commerce_add_to_cart_link.settings to a known state - protect the
# 'authenticated' role's cart links with a CSRF token and enable redirect-back - so an agent
# can read the live config back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("commerce_add_to_cart_link.settings");
  $c->set("csrf_token.roles", ["authenticated"])->set("redirect_back", TRUE)->save();
' >/dev/null 2>&1
echo "setup: commerce_add_to_cart_link.settings csrf_token.roles=[authenticated], redirect_back=true"
