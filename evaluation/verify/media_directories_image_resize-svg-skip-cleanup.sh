#!/usr/bin/env bash
# Introspection CLEANUP: delete the mdir_eval_svg format, its source files and any
# derivatives generated during the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mdir_eval_svg")) { $f->delete(); }
  $fs = \Drupal::service("file_system");
  $fs->deleteRecursive("public://mdir-eval-svg");
  $fs->deleteRecursive("public://resize");
' >/dev/null 2>&1

echo "cleanup: mdir_eval_svg, public://mdir-eval-svg and public://resize removed"
