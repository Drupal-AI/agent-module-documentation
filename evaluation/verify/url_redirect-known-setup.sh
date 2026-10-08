#!/usr/bin/env bash
# Introspection SETUP: create a url_redirect rule urlr_known redirecting /urlr-known-src to
# /urlr-known-dest for the authenticated role (enabled) so an agent can read back its
# destination. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("url_redirect");
  if ($e = $s->load("urlr_known")) { $e->delete(); }
  $s->create([
    "id" => "urlr_known", "label" => "URLR Known",
    "path" => "/urlr-known-src", "redirect_path" => "/urlr-known-dest",
    "redirect_for" => "Role", "roles" => ["authenticated" => "authenticated"], "users" => [],
    "negate" => FALSE, "message" => "No", "status" => 1,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: url_redirect urlr_known /urlr-known-src -> /urlr-known-dest (Role: authenticated)"
