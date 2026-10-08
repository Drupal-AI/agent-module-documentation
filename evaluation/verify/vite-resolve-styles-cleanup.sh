#!/usr/bin/env bash
# Execution CLEANUP: remove the css manifest fixture dir and both state keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  $dir = DRUPAL_ROOT . "/sites/default/files/vite_eval_css";
  \Drupal::service("file_system")->deleteRecursive($dir);
  \Drupal::state()->delete("vite_eval_css_manifest");
  \Drupal::state()->delete("vite_eval_css_result");
' >/dev/null 2>&1
echo "cleanup: vite_eval_css removed; states vite_eval_css_manifest/result deleted"
