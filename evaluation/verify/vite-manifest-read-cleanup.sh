#!/usr/bin/env bash
# Introspection CLEANUP: remove the manifest fixture dir and state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\File\FileSystemInterface;
  $dir = DRUPAL_ROOT . "/sites/default/files/vite_eval_fixture";
  \Drupal::service("file_system")->deleteRecursive($dir);
  \Drupal::state()->delete("vite_eval_manifest_path");
' >/dev/null 2>&1
echo "cleanup: vite_eval_fixture removed; state vite_eval_manifest_path deleted"
