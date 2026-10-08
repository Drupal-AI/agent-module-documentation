#!/usr/bin/env bash
# Execution CLEANUP (openapi_rest): remove the user REST resource, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  if ($c = RestResourceConfig::load("entity.user")) { $c->delete(); }
  \Drupal::service("router.builder")->rebuild();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rest.resource.entity.user removed"
