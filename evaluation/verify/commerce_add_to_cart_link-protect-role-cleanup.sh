#!/usr/bin/env bash
# Execution CLEANUP: restore csrf_token.roles = [] (shipped default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_add_to_cart_link.settings")->set("csrf_token.roles", [])->save();
' >/dev/null 2>&1
echo "cleanup: commerce_add_to_cart_link.settings csrf_token.roles restored to []"
