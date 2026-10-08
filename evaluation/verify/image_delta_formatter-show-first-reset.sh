#!/usr/bin/env bash
# Execution RESET: ensure a multi-value image field field_idf_shots exists on Article rendered
# with the CORE 'image' formatter (NOT the delta formatter) on the default view display, so
# verify FAILS until the agent switches it to image_delta_formatter showing only delta 0.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_idf_shots")) {
    FieldStorageConfig::create(["field_name" => "field_idf_shots", "entity_type" => "node", "type" => "image", "cardinality" => -1])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_idf_shots")) {
    FieldConfig::create(["field_name" => "field_idf_shots", "entity_type" => "node", "bundle" => "article", "label" => "Shots"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_idf_shots", [
    "type" => "image", "label" => "hidden", "weight" => 42, "region" => "content",
    "settings" => ["image_style" => "", "image_link" => ""],
  ])->save();
' >/dev/null 2>&1
echo "reset: node.article field_idf_shots uses core image formatter (NOT delta)"
