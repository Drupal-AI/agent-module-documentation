#!/usr/bin/env bash
# Execution CLEANUP: delete the mfl_tpl_format format + editor, the MFL template media item, its
# file and public://mfl-tpl. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;
  if ($e = Editor::load("mfl_tpl_format")) { $e->delete(); }
  if ($f = FilterFormat::load("mfl_tpl_format")) { $f->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MFL template media"]) as $media) {
    $file = $media->get("field_media_document")->entity;
    $media->delete();
    if ($file) { $file->delete(); }
  }
  \Drupal::service("file_system")->deleteRecursive("public://mfl-tpl");
' >/dev/null 2>&1

echo "cleanup: mfl_tpl_format and MFL template media removed"
