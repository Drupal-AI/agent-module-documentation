#!/usr/bin/env bash
# Execution CLEANUP: remove the hard manifest fixture dir and both state keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  $dir = DRUPAL_ROOT . "/sites/default/files/vite_eval_hard";
  \Drupal::service("file_system")->deleteRecursive($dir);
  \Drupal::state()->delete("vite_eval_hard_manifest");
  \Drupal::state()->delete("vite_eval_hard_result");
' >/dev/null 2>&1
echo "cleanup: vite_eval_hard removed; states vite_eval_hard_manifest/result deleted"
