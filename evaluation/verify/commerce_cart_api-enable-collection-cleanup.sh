#!/usr/bin/env bash
# Execution CLEANUP: remove the commerce_cart_collection REST resource config. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  if ($c = RestResourceConfig::load("commerce_cart_collection")) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rest.resource.commerce_cart_collection removed"
