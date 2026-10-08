#!/usr/bin/env bash
# Introspection SETUP: create a dedicated text format "ckeditor_media_resize_eval" with
# CKEditor 5, the "Resize media images" filter (filter_resize_media) enabled and ordered
# before media_embed, and the ckeditor_media_resize_mediaResize plugin configured with
# apply_image_styles = FALSE. An inspecting agent must read the live filter.format /
# editor.editor config to report which format has the filter and whether dynamic image-style
# scaling is on there. Namespaced to this module; touches no shared format. Idempotent.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\editor\Entity\Editor;
  use Drupal\filter\Entity\FilterFormat;

  $id = "ckeditor_media_resize_eval";
  $format = FilterFormat::load($id) ?: FilterFormat::create([
    "format" => $id,
    "name" => "CKEditor Media Resize eval",
    "weight" => 50,
  ]);
  $format->setFilterConfig("filter_html", [
    "status" => TRUE,
    "weight" => -10,
    "settings" => ["allowed_html" => "<p> <br> <strong> <em> <a href> <drupal-media data-entity-type data-entity-uuid data-view-mode data-media-width>"],
  ]);
  $format->setFilterConfig("filter_resize_media", ["status" => TRUE, "weight" => 0, "settings" => []]);
  $format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100, "settings" => []]);
  $format->save();

  $editor = Editor::load($id) ?: Editor::create(["format" => $id, "editor" => "ckeditor5"]);
  $editor->setSettings([
    "toolbar" => ["items" => ["bold", "italic", "drupalMedia"]],
    "plugins" => [
      "ckeditor_media_resize_mediaResize" => [
        "apply_image_styles" => FALSE,
        "image_styles" => [
          "cke_media_resize_small",
          "cke_media_resize_medium",
          "cke_media_resize_large",
          "cke_media_resize_xl",
        ],
      ],
    ],
  ]);
  $editor->setImageUploadSettings(["status" => FALSE]);
  $editor->save();
' >/dev/null 2>&1

echo "setup: text format ckeditor_media_resize_eval has filter_resize_media enabled, apply_image_styles=FALSE"
