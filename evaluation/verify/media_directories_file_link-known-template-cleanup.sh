#!/usr/bin/env bash
# Introspection CLEANUP: delete the mfl_eval_format format, the MFL doc media item, its file
# and public://mfl. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mfl_eval_format")) { $f->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MFL doc media"]) as $media) {
    $file = $media->get("field_media_document")->entity;
    $media->delete();
    if ($file) { $file->delete(); }
  }
  \Drupal::service("file_system")->deleteRecursive("public://mfl");
' >/dev/null 2>&1

echo "cleanup: mfl_eval_format and MFL doc media removed"
