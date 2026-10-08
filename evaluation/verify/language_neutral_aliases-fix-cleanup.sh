#!/usr/bin/env bash
# Execution CLEANUP: delete the /lna-fix-source alias. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("path_alias");
  foreach ($s->loadByProperties(["path" => "/lna-fix-source"]) as $e) { $e->delete(); }
  \Drupal::database()->delete("path_alias")->condition("path", "/lna-fix-source")->execute();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: /lna-fix-source alias removed"
