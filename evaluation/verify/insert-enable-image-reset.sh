#!/usr/bin/env bash
# Execution RESET: ensure IMAGE field field_insert_pic exists on Article with an image_image widget
# on the default form display and Insert DISABLED (styles empty). Uses a two-save so image_image
# sticks (lightning_media_image swaps a *new* image widget to entity_browser_file on first save,
# but not on the second). verify FAILS until agent enables an insert style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_insert_pic")) {
    FieldStorageConfig::create(["field_name" => "field_insert_pic", "entity_type" => "node", "type" => "image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_insert_pic")) {
    FieldConfig::create(["field_name" => "field_insert_pic", "entity_type" => "node", "bundle" => "article", "label" => "Picture"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_pic", ["type" => "image_image", "weight" => 60, "region" => "content"])->save();
  $fd = $s->load("node.article.default");
  $fd->setComponent("field_insert_pic", [
    "type" => "image_image", "weight" => 60, "region" => "content",
    "third_party_settings" => ["insert" => ["styles" => [], "default" => "insert__auto", "auto_image_style" => "image", "link_image" => NULL, "width" => "", "rotate" => FALSE]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_insert_pic image_image, Insert disabled (styles empty)"
