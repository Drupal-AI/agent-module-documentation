#!/usr/bin/env bash
# Execution CLEANUP: remove the target file entity if it still exists and its directory.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  $ids = \Drupal::entityTypeManager()->getStorage("file")->getQuery()
    ->accessCheck(FALSE)->condition("filename", "fdu_eval_target.txt")->execute();
  foreach (File::loadMultiple($ids) as $f) { $f->delete(); }
  \Drupal::service("file_system")->deleteRecursive("public://file_delete_ui_eval");
' >/dev/null 2>&1
echo "cleanup: target file removed"
