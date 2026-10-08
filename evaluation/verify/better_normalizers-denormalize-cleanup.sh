#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -f /tmp/bnrm-eval/in.json
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["filename" => "bnrm-restore.txt"]) as $f) { $f->delete(); }
  $real = \Drupal::service("file_system")->realpath("public://bnrm_eval/restore.txt");
  if ($real && is_file($real)) { @unlink($real); }
' >/dev/null 2>&1
echo "cleanup: bnrm-restore.txt + in.json removed"
