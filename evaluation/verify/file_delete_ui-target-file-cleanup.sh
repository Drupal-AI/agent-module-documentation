#!/usr/bin/env bash
# Introspection CLEANUP: delete the managed file created by setup and its directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  $ids = \Drupal::entityTypeManager()->getStorage("file")->getQuery()
    ->accessCheck(FALSE)->condition("filename", "fdu_eval_lookup.txt")->execute();
  foreach (File::loadMultiple($ids) as $f) { $f->delete(); }
  $fs = \Drupal::service("file_system");
  $fs->deleteRecursive("public://file_delete_ui_eval");
' >/dev/null 2>&1
echo "cleanup: managed file fdu_eval_lookup.txt removed"
