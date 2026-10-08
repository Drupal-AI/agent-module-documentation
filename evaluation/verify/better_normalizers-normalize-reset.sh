#!/usr/bin/env bash
# Execution RESET: ensure a known File entity exists to serialize and remove any prior output so
# verify FAILS on empty state. Idempotent.
set -uo pipefail
cd /var/www/html
mkdir -p /tmp/bnrm-eval; rm -f /tmp/bnrm-eval/file-out.json
drush php:eval '
  use Drupal\file\Entity\File;
  $fs = \Drupal::service("file_system");
  $dir = "public://bnrm_eval";
  $fs->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["filename" => "bnrm-eval-spec.txt"]) as $f) { $f->delete(); }
  file_put_contents($fs->realpath($dir)."/spec.txt", "BNRM-EVAL-CONTENT-42");
  File::create(["uri" => $dir."/spec.txt", "filename" => "bnrm-eval-spec.txt", "status" => 1])->save();
' >/dev/null 2>&1
echo "reset: File bnrm-eval-spec.txt ready; /tmp/bnrm-eval/file-out.json removed"
