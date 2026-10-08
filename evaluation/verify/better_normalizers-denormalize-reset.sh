#!/usr/bin/env bash
# Execution RESET: produce a HAL json document (with embedded base64 contents) at
# /tmp/bnrm-eval/in.json for a file, then remove the file entity and its bytes so the target path
# is empty (verify FAILS until the agent reconstructs it). Idempotent.
set -uo pipefail
cd /var/www/html
mkdir -p /tmp/bnrm-eval
drush php:eval '
  use Drupal\file\Entity\File;
  $fs = \Drupal::service("file_system");
  $dir = "public://bnrm_eval";
  $fs->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["filename" => "bnrm-restore.txt"]) as $f) { $f->delete(); }
  $real = $fs->realpath($dir)."/restore.txt";
  file_put_contents($real, "RESTORE-BYTES-88");
  $file = File::create(["uri" => $dir."/restore.txt", "filename" => "bnrm-restore.txt", "status" => 1]);
  $file->save();
  $json = \Drupal::service("serializer")->serialize($file, "hal_json");
  file_put_contents("/tmp/bnrm-eval/in.json", $json);
  // wipe entity + bytes so the file must be reconstructed from the json
  $file->delete();
  @unlink($real);
' >/dev/null 2>&1
echo "reset: /tmp/bnrm-eval/in.json written; restore.txt bytes removed"
