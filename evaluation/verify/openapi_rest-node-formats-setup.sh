#!/usr/bin/env bash
# Introspection SETUP (openapi_rest): create the core REST resource config for the node entity
# (entity.node) exposing GET with serializer formats json + xml and cookie auth, so an inspecting
# agent can read back which formats are enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  use Drupal\rest\RestResourceConfigInterface;
  $c = RestResourceConfig::load("entity.node");
  if (!$c) { $c = RestResourceConfig::create(["id" => "entity.node", "plugin_id" => "entity:node"]); }
  $c->set("granularity", RestResourceConfigInterface::METHOD_GRANULARITY);
  $c->set("configuration", ["GET" => ["supported_formats" => ["json", "xml"], "supported_auth" => ["cookie"]]]);
  $c->save();
  \Drupal::service("router.builder")->rebuild();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rest.resource.entity.node GET formats=[json,xml] auth=[cookie]"
