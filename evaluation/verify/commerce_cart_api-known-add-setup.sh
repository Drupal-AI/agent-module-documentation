#!/usr/bin/env bash
# Introspection SETUP: activate the commerce_cart_add REST resource (POST /cart/add, json, cookie)
# by creating its rest.resource config entity, so the agent can inspect the live REST config to
# report the enabled add-to-cart endpoint's method/path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  use Drupal\rest\RestResourceConfigInterface;
  if (!RestResourceConfig::load("commerce_cart_add")) {
    RestResourceConfig::create([
      "id" => "commerce_cart_add", "plugin_id" => "commerce_cart_add",
      "granularity" => RestResourceConfigInterface::RESOURCE_GRANULARITY,
      "configuration" => ["methods" => ["POST"], "formats" => ["json"], "authentication" => ["cookie"]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rest.resource.commerce_cart_add enabled (POST /cart/add)"
