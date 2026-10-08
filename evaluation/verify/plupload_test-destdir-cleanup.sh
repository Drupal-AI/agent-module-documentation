#!/usr/bin/env bash
# Execution CLEANUP: remove the destination directory created for this case. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $dir = "public://plupload-test";
  $fs = \Drupal::service("file_system");
  if (is_dir($fs->realpath($dir) ?: "/nonexistent")) { $fs->deleteRecursive($dir); }
' >/dev/null 2>&1
echo "cleanup: public://plupload-test removed"
