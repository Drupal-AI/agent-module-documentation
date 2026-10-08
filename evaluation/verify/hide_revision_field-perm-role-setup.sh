#!/usr/bin/env bash
# Introspection SETUP: grant the "Content editor" (content_editor) role the module's
# `access revision field` permission, so an inspecting agent can report which role holds it.
# Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $r = \Drupal::entityTypeManager()->getStorage("user_role")->load("content_editor");
  if ($r && !$r->hasPermission("access revision field")) {
    $r->grantPermission("access revision field")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content_editor granted 'access revision field'"
