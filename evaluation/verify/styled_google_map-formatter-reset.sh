#!/usr/bin/env bash
# Execution RESET: ensure geofield field_sgm_map exists on Article, but REMOVE it from the
# default view display so no styled map is shown (verify FAILS until the agent adds the
# styled_google_map_default formatter). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_sgm_map")) {
    FieldStorageConfig::create([
      "field_name" => "field_sgm_map", "entity_type" => "node", "type" => "geofield",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_sgm_map")) {
    FieldConfig::create([
      "field_name" => "field_sgm_map", "entity_type" => "node",
      "bundle" => "article", "label" => "Map Location",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->removeComponent("field_sgm_map")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_sgm_map present but NOT shown as a styled map"
