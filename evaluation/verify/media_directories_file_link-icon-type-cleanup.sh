#!/usr/bin/env bash
# Introspection CLEANUP: delete the mfl_icon_format format, the MFL zip media item, its file
# and public://mfl-icon. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mfl_icon_format")) { $f->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MFL zip media"]) as $media) {
    $file = $media->get("field_media_document")->entity;
    $media->delete();
    if ($file) { $file->delete(); }
  }
  \Drupal::service("file_system")->deleteRecursive("public://mfl-icon");
' >/dev/null 2>&1

echo "cleanup: mfl_icon_format and MFL zip media removed"
