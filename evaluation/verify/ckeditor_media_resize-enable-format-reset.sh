#!/usr/bin/env bash
# Execution RESET for "enable media resizing on the ckeditor_media_resize_task format".
# Creates (or rebuilds) a CKEditor 5 text format that has filter_html + media_embed but
# deliberately NO filter_resize_media, no drupalMedia toolbar item and no
# ckeditor_media_resize_mediaResize plugin settings — so verify FAILS until the agent wires
# the module up. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;

  $id = "ckeditor_media_resize_task";
  if ($e = Editor::load($id)) { $e->delete(); }
  if ($f = FilterFormat::load($id)) { $f->delete(); }

  $format = FilterFormat::create([
    "format" => $id,
    "name" => "CKEditor Media Resize task",
    "weight" => 52,
  ]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE,
    "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <strong> <em> <drupal-media data-entity-type data-entity-uuid data-view-mode>"],
  ]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100, "settings" => []]);
  $format->save();

  $editor = Editor::create(["format" => $id, "editor" => "ckeditor5"]);
  $editor->setSettings([
    "toolbar" => ["items" => ["bold", "italic"]],
    "plugins" => [],
  ]);
  $editor->setImageUploadSettings(["status" => FALSE]);
  $editor->save();
' >/dev/null 2>&1

echo "reset: ckeditor_media_resize_task format rebuilt WITHOUT filter_resize_media / drupalMedia / plugin settings"
