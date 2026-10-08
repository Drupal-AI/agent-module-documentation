#!/usr/bin/env bash
# Introspection SETUP: create a known File entity so the agent can serialize it to hal_json and
# see how better_normalizers embeds its contents. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\file\Entity\File;
  $fs = \Drupal::service("file_system");
  $dir = "public://bnrm_eval";
  $fs->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["filename" => "bnrm-eval-marker.txt"]) as $f) { $f->delete(); }
  file_put_contents($fs->realpath($dir)."/marker.txt", "MARKER-BYTES-9");
  File::create(["uri" => $dir."/marker.txt", "filename" => "bnrm-eval-marker.txt", "status" => 1])->save();
' >/dev/null 2>&1
echo "setup: File entity bnrm-eval-marker.txt (content MARKER-BYTES-9) created"
