#!/usr/bin/env bash
# Introspection SETUP: create a geofield field_sgm_known on Article and display it with the
# styled_google_map_default formatter (width 777px) on the default view display. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_sgm_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_sgm_known", "entity_type" => "node", "type" => "geofield",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_sgm_known")) {
    FieldConfig::create([
      "field_name" => "field_sgm_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Location",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_sgm_known", [
    "type" => "styled_google_map_default", "label" => "hidden", "weight" => 40,
    "region" => "content", "settings" => ["width" => "777px", "height" => "333px"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_sgm_known displayed with styled_google_map_default (width 777px)"
