#!/usr/bin/env bash
# Introspection SETUP: create text format "ckeditor_media_resize_styles" whose
# ckeditor_media_resize_mediaResize plugin has apply_image_styles = TRUE but a *restricted*
# image_styles list (only cke_media_resize_small and cke_media_resize_xl). An inspecting
# agent must read the live editor.editor config to work out which view mode a given resize
# width maps to. Namespaced to this module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;

  $id = "ckeditor_media_resize_styles";
  $format = FilterFormat::load($id) ?: FilterFormat::create([
    "format" => $id,
    "name" => "CKEditor Media Resize styles eval",
    "weight" => 51,
  ]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE,
    "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <drupal-media data-entity-type data-entity-uuid data-view-mode data-media-width>"],
  ]);
  $format->setFilterConfig("filter_resize_media", ["status" => TRUE, "weight" => 0, "settings" => []]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100, "settings" => []]);
  $format->save();

  $editor = Editor::load($id) ?: Editor::create(["format" => $id, "editor" => "ckeditor5"]);
  $editor->setSettings([
    "toolbar" => ["items" => ["bold", "drupalMedia"]],
    "plugins" => [
      "ckeditor_media_resize_mediaResize" => [
        "apply_image_styles" => TRUE,
        "image_styles" => ["cke_media_resize_small", "cke_media_resize_xl"],
      ],
    ],
  ]);
  $editor->setImageUploadSettings(["status" => FALSE]);
  $editor->save();
' >/dev/null 2>&1

echo "setup: ckeditor_media_resize_styles format -> image_styles = [cke_media_resize_small, cke_media_resize_xl], apply_image_styles=TRUE"
