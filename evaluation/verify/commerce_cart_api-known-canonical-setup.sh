#!/usr/bin/env bash
# Introspection SETUP: activate the commerce_cart_canonical REST resource (GET a single cart) by
# creating its rest.resource config, so the agent can inspect the live REST config to report the
# enabled endpoint's method/path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  use Drupal\rest\RestResourceConfigInterface;
  if (!RestResourceConfig::load("commerce_cart_canonical")) {
    RestResourceConfig::create([
      "id" => "commerce_cart_canonical", "plugin_id" => "commerce_cart_canonical",
      "granularity" => RestResourceConfigInterface::RESOURCE_GRANULARITY,
      "configuration" => ["methods" => ["GET"], "formats" => ["json"], "authentication" => ["cookie"]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rest.resource.commerce_cart_canonical enabled (GET /cart/{commerce_order})"
