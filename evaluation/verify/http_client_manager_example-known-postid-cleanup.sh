#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped find_post postId to its default ('1'). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("http_config_request")->load("find_post");
  if ($e) { $p = $e->get("parameters"); $p["postId"] = "1"; $e->set("parameters", $p)->save(); }
' >/dev/null 2>&1
echo "cleanup: find_post parameters.postId restored to 1"
