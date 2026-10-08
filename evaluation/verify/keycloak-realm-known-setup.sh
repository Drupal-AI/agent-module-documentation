#!/usr/bin/env bash
# Introspection SETUP: create a Keycloak OpenID Connect client (openid_connect.client.kc_realm,
# plugin keycloak) with a known base URL and realm so an inspecting agent can read them back.
# No live Keycloak server is contacted; this is pure config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("openid_connect_client");
  if ($e = $s->load("kc_realm")) { $e->delete(); }
  $s->create([
    "id" => "kc_realm", "label" => "KC Realm Known", "plugin" => "keycloak",
    "settings" => [
      "client_id" => "drupal", "client_secret" => "x",
      "keycloak_base" => "https://id.example.com", "keycloak_realm" => "acme",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: openid_connect.client.kc_realm (keycloak) base=https://id.example.com realm=acme"
