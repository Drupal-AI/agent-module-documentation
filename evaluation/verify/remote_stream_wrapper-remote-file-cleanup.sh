#!/usr/bin/env bash
# Execution CLEANUP: delete any managed file entity named rsw_task_remote.png or pointing at the
# task URL, and remove any locally downloaded copy, so the site has NO remote file entity and
# the verify fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("file");
  foreach ($storage->loadByProperties(["filename" => "rsw_task_remote.png"]) as $f) { $f->delete(); }
  foreach ($storage->loadByProperties(["uri" => "http://web/core/misc/druplicon.png"]) as $f) { $f->delete(); }
  \Drupal::service("file_system")->deleteRecursive("public://rsw_task");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: no managed file for http://web/core/misc/druplicon.png"
