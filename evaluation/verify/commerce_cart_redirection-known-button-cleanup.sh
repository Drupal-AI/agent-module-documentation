#!/usr/bin/env bash
# Introspection CLEANUP: remove commerce_cart_redirection.settings to restore baseline
# (a fresh install has no config object until the form is saved). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_cart_redirection.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: commerce_cart_redirection.settings deleted"
