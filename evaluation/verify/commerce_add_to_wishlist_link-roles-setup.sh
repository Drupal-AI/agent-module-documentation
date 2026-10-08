#!/usr/bin/env bash
# Introspection SETUP: protect the 'content_editor' role in commerce_add_to_cart_link.settings
# csrf_token.roles - the shared token config that also applies to add-to-wishlist links (they use
# the commerce_add_to_cart_link.token service). Lets an agent read which role is protected. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_add_to_cart_link.settings")->set("csrf_token.roles", ["content_editor"])->save();
' >/dev/null 2>&1
echo "setup: commerce_add_to_cart_link.settings csrf_token.roles=[content_editor] (applies to wishlist links)"
