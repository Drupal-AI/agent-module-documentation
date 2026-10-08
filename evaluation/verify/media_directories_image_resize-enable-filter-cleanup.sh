#!/usr/bin/env bash
# Execution CLEANUP: remove the mdir_enable_format format, its source image and every
# generated derivative. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mdir_enable_format")) { $f->delete(); }
  $fs = \Drupal::service("file_system");
  $fs->deleteRecursive("public://mdir-enable");
  $fs->deleteRecursive("public://resize");
' >/dev/null 2>&1

echo "cleanup: mdir_enable_format, public://mdir-enable and public://resize removed"
