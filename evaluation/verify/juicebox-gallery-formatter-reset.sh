#!/usr/bin/env bash
# Execution RESET for "configure the Article gallery field to the Juicebox formatter".
# Ensures an image field (field_jb_gallery, unlimited) exists on node.article, then forces a
# clean, known-WRONG baseline so verify FAILS until the agent does the work: the field's
# default view display component is set to core's plain "image" formatter (image_style empty).
# The agent must switch it to juicebox_formatter with the required settings. Idempotent.
# Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_jb_gallery")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_jb_gallery", "entity_type" => "node",
      "type" => "image", "cardinality" => -1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_jb_gallery")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_jb_gallery", "entity_type" => "node", "bundle" => "article",
      "label" => "Gallery",
      "settings" => ["alt_field" => TRUE, "title_field" => TRUE],
    ])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $vd->setComponent("field_jb_gallery", [
    "type" => "image",
    "label" => "above",
    "region" => "content",
    "weight" => 21,
    "settings" => ["image_style" => "", "image_link" => ""],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_jb_gallery -> core image formatter (agent must switch it to juicebox_formatter)"
