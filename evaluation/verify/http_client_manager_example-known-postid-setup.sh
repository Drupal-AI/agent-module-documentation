#!/usr/bin/env bash
# Introspection SETUP: set the shipped find_post config request's postId to a known value (9).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("http_config_request")->load("find_post");
  if ($e) { $p = $e->get("parameters"); $p["postId"] = "9"; $e->set("parameters", $p)->save(); }
' >/dev/null 2>&1
echo "setup: find_post parameters.postId=9"
