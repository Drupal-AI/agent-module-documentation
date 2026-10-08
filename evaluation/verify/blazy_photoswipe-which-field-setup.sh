#!/usr/bin/env bash
# Introspection SETUP: create an image field field_bps_img on Article and set its Blazy
# formatter's Media switch to photoswipe in the default view display, so the agent must
# inspect the live display to find which field opens images in PhotoSwipe. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bps_img")) {
    FieldStorageConfig::create([
      "field_name" => "field_bps_img", "entity_type" => "node",
      "type" => "image", "cardinality" => -1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bps_img")) {
    FieldConfig::create([
      "field_name" => "field_bps_img", "entity_type" => "node",
      "bundle" => "article", "label" => "BPS Gallery",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_bps_img", [
    "type" => "blazy", "weight" => 60, "region" => "content",
    "settings" => ["media_switch" => "photoswipe"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_bps_img (blazy) media_switch=photoswipe"
