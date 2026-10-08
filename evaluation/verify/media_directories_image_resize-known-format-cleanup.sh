#!/usr/bin/env bash
# Introspection CLEANUP: delete the mdir_eval_format text format, the source image and any
# derivatives generated from it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mdir_eval_format")) { $f->delete(); }
  $fs = \Drupal::service("file_system");
  $fs->deleteRecursive("public://mdir-eval");
  $fs->deleteRecursive("public://resize");
' >/dev/null 2>&1

echo "cleanup: mdir_eval_format, public://mdir-eval and public://resize removed"
