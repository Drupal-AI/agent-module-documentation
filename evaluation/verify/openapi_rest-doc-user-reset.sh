#!/usr/bin/env bash
# Execution RESET (openapi_rest): remove any REST resource config for the user entity so the
# generated OpenAPI spec does NOT contain a /user/{user} path (verify must FAIL on this empty
# state). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  if ($c = RestResourceConfig::load("entity.user")) { $c->delete(); }
  \Drupal::service("router.builder")->rebuild();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rest.resource.entity.user removed"
