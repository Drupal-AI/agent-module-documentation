#!/usr/bin/env bash
# Execution RESET: delete commerce_cart_redirection.settings so nothing is configured
# (verify FAILS until the agent configures a cart redirect for the default bundle). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_cart_redirection.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: commerce_cart_redirection.settings deleted"
