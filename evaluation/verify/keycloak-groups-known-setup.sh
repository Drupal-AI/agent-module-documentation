#!/usr/bin/env bash
# Introspection SETUP: create a Keycloak client (openid_connect.client.kc_groups) that has
# group->role mapping enabled with a known claim name and one rule mapping the Drupal role
# 'editor', so an inspecting agent can read the mapping back. Pure config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("openid_connect_client");
  if ($e = $s->load("kc_groups")) { $e->delete(); }
  $s->create([
    "id" => "kc_groups", "label" => "KC Groups Known", "plugin" => "keycloak",
    "settings" => [
      "client_id" => "drupal", "client_secret" => "x",
      "keycloak_base" => "https://id.example.com", "keycloak_realm" => "acme",
      "keycloak_groups" => [
        "enabled" => TRUE, "claim_name" => "groups", "split_groups" => TRUE,
        "rules" => [
          ["id" => "editors", "role" => "editor", "action" => "add", "operation" => "equals", "pattern" => "/editors", "case_sensitive" => FALSE, "weight" => 0, "enabled" => TRUE],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: openid_connect.client.kc_groups keycloak_groups enabled claim_name=groups role=editor"
