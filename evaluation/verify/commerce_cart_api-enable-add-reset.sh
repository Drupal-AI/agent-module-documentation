#!/usr/bin/env bash
# Execution RESET: ensure the commerce_cart_add REST resource is NOT enabled (delete its
# rest.resource config), so verify FAILS until the agent enables the add-to-cart endpoint.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  if ($c = RestResourceConfig::load("commerce_cart_add")) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rest.resource.commerce_cart_add absent"
