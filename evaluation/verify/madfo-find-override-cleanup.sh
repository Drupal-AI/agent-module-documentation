#!/usr/bin/env bash
# Introspection CLEANUP: delete the two eval media items. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["MAD Eval Override", "MAD Eval Normal"] as $name) {
    foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => $name]) as $m) { $m->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: MAD Eval Override / MAD Eval Normal removed"
