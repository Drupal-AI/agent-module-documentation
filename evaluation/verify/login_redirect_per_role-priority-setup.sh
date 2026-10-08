#!/usr/bin/env bash
# Introspection SETUP: configure TWO login rows so priority (weight) decides the outcome.
# content_editor (weight 0) -> /dashboard-editor ; authenticated (weight 1) -> /user.
# A user holding both roles should be redirected by the lower-weight (content_editor) row.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("login_redirect_per_role.settings");
  $c->set("login", [
    "content_editor" => ["redirect_url" => "/dashboard-editor", "allow_destination" => FALSE, "weight" => 0],
    "authenticated"  => ["redirect_url" => "/user",             "allow_destination" => FALSE, "weight" => 1],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content_editor(w0)->/dashboard-editor, authenticated(w1)->/user"
