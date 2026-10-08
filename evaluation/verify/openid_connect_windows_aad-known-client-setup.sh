#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN openid_connect_client config entity that uses the
# windows_aad plugin with distinctive settings (tenant endpoints, manual group->role
# mapping to "editor", Microsoft Graph v1.0, subject_key oid) so an inspecting agent can
# read its plugin id and settings back with drush. No such client ships by default, so it
# is safe to create/delete. Idempotent (recreated each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("openid_connect_client");
  if ($existing = $storage->load("eval_entra")) { $existing->delete(); }
  $storage->create([
    "id" => "eval_entra",
    "label" => "Eval Entra Tenant",
    "plugin" => "windows_aad",
    "settings" => [
      "client_id" => "eval-app-0001",
      "client_secret" => "eval_secret_key",
      "authorization_endpoint_wa" => "https://login.microsoftonline.com/contoso-eval/oauth2/v2.0/authorize",
      "token_endpoint_wa" => "https://login.microsoftonline.com/contoso-eval/oauth2/v2.0/token",
      "map_ad_groups_to_roles" => TRUE,
      "group_mapping" => ["method" => 1, "mappings" => "editor|00000000-1111-2222-3333-444444444444", "strict" => TRUE],
      "userinfo_graph_api_wa" => 2,
      "subject_key" => "oid",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: openid_connect_client eval_entra created (plugin windows_aad, group->editor, graph v1.0, subject_key oid)"
