#!/usr/bin/env bash
# Introspection CLEANUP: delete both managed files created by the matching setup and the
# public://rsw_eval directory. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("file");
  foreach (["rsw_eval_remote.png", "rsw_eval_local.png"] as $name) {
    foreach ($storage->loadByProperties(["filename" => $name]) as $f) { $f->delete(); }
  }
  \Drupal::service("file_system")->deleteRecursive("public://rsw_eval");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rsw_eval_remote.png, rsw_eval_local.png and public://rsw_eval removed"
