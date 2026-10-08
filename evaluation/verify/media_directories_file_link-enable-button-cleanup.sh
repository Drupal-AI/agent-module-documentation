#!/usr/bin/env bash
# Execution CLEANUP: delete the mfl_task_format format + editor, the MFL task media item, its
# file and public://mfl-task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;
  if ($e = Editor::load("mfl_task_format")) { $e->delete(); }
  if ($f = FilterFormat::load("mfl_task_format")) { $f->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MFL task media"]) as $media) {
    $file = $media->get("field_media_document")->entity;
    $media->delete();
    if ($file) { $file->delete(); }
  }
  \Drupal::service("file_system")->deleteRecursive("public://mfl-task");
' >/dev/null 2>&1

echo "cleanup: mfl_task_format and MFL task media removed"
