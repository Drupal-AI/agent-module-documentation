#!/usr/bin/env bash
# Execution RESET (openapi_rest): remove any REST resource config for the node entity so the
# generated OpenAPI spec does NOT contain a /node/{node} path (verify must FAIL on empty state).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  if ($c = RestResourceConfig::load("entity.node")) { $c->delete(); }
  \Drupal::service("router.builder")->rebuild();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rest.resource.entity.node removed"
