#!/usr/bin/env bash
# Execution RESET: ensure Article has an image field field_erim_img whose default view-display
# component uses the plain core 'image' formatter (so verify for easy_responsive_images FAILS).
# Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_erim_img")) {
    FieldStorageConfig::create(["field_name" => "field_erim_img", "entity_type" => "node", "type" => "image"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_erim_img")) {
    FieldConfig::create(["field_name" => "field_erim_img", "entity_type" => "node", "bundle" => "article", "label" => "ERIM Image"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_erim_img", ["type" => "image", "label" => "hidden", "weight" => 80, "region" => "content", "settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_erim_img uses core image formatter"
