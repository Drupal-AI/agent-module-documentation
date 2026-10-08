#!/usr/bin/env bash
# Introspection SETUP (openapi_rest): create the core REST resource config for the taxonomy_term
# entity exposing GET and DELETE (json, cookie), so an inspecting agent can read back which HTTP
# methods are enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  use Drupal\rest\RestResourceConfigInterface;
  $c = RestResourceConfig::load("entity.taxonomy_term");
  if (!$c) { $c = RestResourceConfig::create(["id" => "entity.taxonomy_term", "plugin_id" => "entity:taxonomy_term"]); }
  $c->set("granularity", RestResourceConfigInterface::METHOD_GRANULARITY);
  $c->set("configuration", [
    "GET" => ["supported_formats" => ["json"], "supported_auth" => ["cookie"]],
    "DELETE" => ["supported_formats" => ["json"], "supported_auth" => ["cookie"]],
  ]);
  $c->save();
  \Drupal::service("router.builder")->rebuild();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rest.resource.entity.taxonomy_term methods=[GET,DELETE]"
