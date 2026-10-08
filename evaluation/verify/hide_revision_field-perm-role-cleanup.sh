#!/usr/bin/env bash
# Introspection CLEANUP: revoke `access revision field` from the content_editor role,
# restoring the baseline where no custom role holds the module permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $r = \Drupal::entityTypeManager()->getStorage("user_role")->load("content_editor");
  if ($r && $r->hasPermission("access revision field")) {
    $r->revokePermission("access revision field")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content_editor 'access revision field' revoked"
