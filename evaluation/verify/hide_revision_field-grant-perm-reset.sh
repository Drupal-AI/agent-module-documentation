#!/usr/bin/env bash
# Execution RESET for "grant the access revision field permission to the content_editor role".
# Ensures the WRONG baseline (permission NOT granted) so verify FAILS until the agent grants it.
# Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $r = \Drupal::entityTypeManager()->getStorage("user_role")->load("content_editor");
  if ($r && $r->hasPermission("access revision field")) {
    $r->revokePermission("access revision field")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content_editor does NOT have 'access revision field' (agent must grant it)"
