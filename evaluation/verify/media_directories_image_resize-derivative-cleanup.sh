#!/usr/bin/env bash
# Execution CLEANUP: remove the mdir_task_format format, the task source image and every
# generated derivative. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mdir_task_format")) { $f->delete(); }
  $fs = \Drupal::service("file_system");
  $fs->deleteRecursive("public://mdir-task");
  $fs->deleteRecursive("public://resize");
' >/dev/null 2>&1

echo "cleanup: mdir_task_format, public://mdir-task and public://resize removed"
