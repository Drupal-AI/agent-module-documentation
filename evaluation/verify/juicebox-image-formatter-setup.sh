#!/usr/bin/env bash
# Introspection SETUP for Juicebox medium cases. Ensures an image field
# (field_jb_probe, unlimited) exists on node.article, then sets the Article "default"
# entity_view_display to render it with the KNOWN Juicebox formatter config so an
# inspecting agent can read it back:
#   type=juicebox_formatter, image_style=juicebox_medium, thumb_style=juicebox_square_thumb,
#   caption_source=alt, title_source=title.
# Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_jb_probe")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_jb_probe", "entity_type" => "node",
      "type" => "image", "cardinality" => -1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_jb_probe")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_jb_probe", "entity_type" => "node", "bundle" => "article",
      "label" => "JB probe gallery",
      "settings" => ["alt_field" => TRUE, "title_field" => TRUE],
    ])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $vd->setComponent("field_jb_probe", [
    "type" => "juicebox_formatter",
    "label" => "hidden",
    "region" => "content",
    "weight" => 20,
    "settings" => [
      "image_style" => "juicebox_medium",
      "thumb_style" => "juicebox_square_thumb",
      "caption_source" => "alt",
      "title_source" => "title",
    ],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_jb_probe -> juicebox_formatter (image_style=juicebox_medium, thumb_style=juicebox_square_thumb, caption_source=alt, title_source=title)"
