#!/usr/bin/env bash
# Execution RESET: remove the public://plupload-test destination directory so verify FAILS
# until it is (re)created. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $dir = "public://plupload-test";
  $fs = \Drupal::service("file_system");
  if (is_dir($fs->realpath($dir) ?: "/nonexistent")) { $fs->deleteRecursive($dir); }
' >/dev/null 2>&1
echo "reset: public://plupload-test removed"
