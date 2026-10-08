#!/usr/bin/env bash
# Introspection SETUP: create a multi-value image field field_idf_gallery on Article and set its
# default view-display formatter to image_delta_formatter showing deltas 0 and 2, so an agent
# can read the configured formatter/deltas back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_idf_gallery")) {
    FieldStorageConfig::create(["field_name" => "field_idf_gallery", "entity_type" => "node", "type" => "image", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_idf_gallery")) {
    FieldConfig::create(["field_name" => "field_idf_gallery", "entity_type" => "node", "bundle" => "article", "label" => "Gallery"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_idf_gallery", [
    "type" => "image_delta_formatter", "label" => "hidden", "weight" => 40, "region" => "content",
    "settings" => ["deltas" => [0, 2], "deltas_reversed" => FALSE, "image_style" => "", "image_link" => ""],
  ])->save();
' >/dev/null 2>&1
echo "setup: node.article field_idf_gallery uses image_delta_formatter deltas=[0,2]"
