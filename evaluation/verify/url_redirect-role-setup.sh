#!/usr/bin/env bash
# Introspection SETUP: create a url_redirect rule urlr_role targeting the 'anonymous' role, so
# the agent must inspect it to state which role it applies to. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("url_redirect");
  if ($e = $s->load("urlr_role")) { $e->delete(); }
  $s->create([
    "id" => "urlr_role", "label" => "URLR Role",
    "path" => "/urlr-role-src", "redirect_path" => "/user/login",
    "redirect_for" => "Role", "roles" => ["anonymous" => "anonymous"], "users" => [],
    "negate" => FALSE, "message" => "No", "status" => 1,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: url_redirect urlr_role targets role anonymous"
