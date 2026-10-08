#!/usr/bin/env bash
# Introspection CLEANUP: delete the /lna-src-b alias. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("path_alias");
  foreach ($s->loadByProperties(["path" => "/lna-src-b"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: /lna-src-b alias removed"
