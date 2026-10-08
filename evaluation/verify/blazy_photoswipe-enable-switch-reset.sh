#!/usr/bin/env bash
# Execution RESET: ensure image field field_bps_task exists on Article with a Blazy formatter
# whose Media switch is EMPTY (no photoswipe), so verify FAILS until the agent enables it.
# Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bps_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_bps_task", "entity_type" => "node",
      "type" => "image", "cardinality" => -1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bps_task")) {
    FieldConfig::create([
      "field_name" => "field_bps_task", "entity_type" => "node",
      "bundle" => "article", "label" => "BPS Task Gallery",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_bps_task", [
    "type" => "blazy", "weight" => 61, "region" => "content",
    "settings" => ["media_switch" => ""],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_bps_task (blazy) media_switch empty"
