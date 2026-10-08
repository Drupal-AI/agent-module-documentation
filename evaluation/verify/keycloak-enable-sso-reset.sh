#!/usr/bin/env bash
# Execution RESET: (re)create a Keycloak client openid_connect.client.kc_sso with SSO and
# single sign-out turned OFF, so verify FAILS until the agent enables them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("openid_connect_client");
  if ($e = $s->load("kc_sso")) { $e->delete(); }
  $s->create([
    "id" => "kc_sso", "label" => "KC SSO Task", "plugin" => "keycloak",
    "settings" => [
      "client_id" => "drupal", "client_secret" => "x",
      "keycloak_base" => "https://id.example.com", "keycloak_realm" => "acme",
      "keycloak_sso" => FALSE, "keycloak_sign_out" => FALSE,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: openid_connect.client.kc_sso present with keycloak_sso=FALSE keycloak_sign_out=FALSE"
