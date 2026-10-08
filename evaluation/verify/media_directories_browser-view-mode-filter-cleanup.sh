#!/usr/bin/env bash
# Execution CLEANUP: delete the throwaway mdb_task_format text format, its editor entity
# and the "MDB task image" media item (and file) created by the reset script.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;
  if ($e = Editor::load("mdb_task_format")) { $e->delete(); }
  if ($f = FilterFormat::load("mdb_task_format")) { $f->delete(); }

  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MDB task image"]) as $media) {
    $file = $media->get("field_media_image")->entity;
    $media->delete();
    if ($file) { $file->delete(); }
  }
' >/dev/null 2>&1

echo "cleanup: mdb_task_format and MDB task image removed"
