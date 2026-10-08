#!/usr/bin/env bash
# Introspection SETUP: write a known LOGIN redirect for the content_editor role into
# login_redirect_per_role.settings so an inspecting agent can read back the destination URL.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("login_redirect_per_role.settings");
  $login = $c->get("login") ?? [];
  $login["content_editor"] = ["redirect_url" => "/admin/content", "allow_destination" => FALSE, "weight" => 0];
  $c->set("login", $login)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: login.content_editor.redirect_url=/admin/content"
